require 'uri'
require 'zlib'
require 'stringio'
require 'ebay/request/connection'
require 'ebay/inventory/requests'
require 'ebay/inventory/responses'
require 'ebay/inventory/api_methods'

module Ebay #:nodoc:
  module Inventory # :nodoc:

    # == Overview
    # Api is the main proxy class responsible for instantiating and invoking
    # the correct Ebay::Inventory::Requests object for the method called.
    #
    # http://developer.ebay.com/DevZone/store-pickup/InventoryManagement/
    class Api
      include Inflections
      include ApiMethods

      cattr_accessor :use_sandbox, :sandbox_url, :production_url
      cattr_accessor :auth_token
      cattr_accessor :logger

      attr_reader :auth_token

      self.sandbox_url = 'https://api.sandbox.ebay.com/selling/inventory/v1'
      self.production_url = 'https://api.ebay.com/selling/inventory/v1'
      self.use_sandbox = false

      # The URI that all requests are sent to. This depends on the current environment the Api
      # is configured to use and will either be the Api#sandbox_url or the Api#production_url
      def self.service_uri
        URI.parse(using_sandbox? ? sandbox_url : production_url)
      end

      # Are we currently routing requests to the eBay sandbox URL?
      def self.using_sandbox?
        use_sandbox
      end

      # Are we currently routing requests to the eBay production URL?
      def self.using_production?
        !using_sandbox?
      end

      # Simply yields the Ebay::Api class itself.  This makes configuration a bit nicer looking:
      #
      #  Ebay::Inventory::Api.configure do |ebay|
      #    ebay.auth_token = 'YOUR AUTH TOKEN HERE'
      #
      #  # The default environment is the production environment
      #  # Override by setting use_sandbox to true
      #    ebay.use_sandbox = true
      #  end
      def self.configure
        yield self if block_given?
      end

      # The schema version the API client is currently using
      def schema_version
        Ebay::Schema::VERSION.to_s
      end

      def service_uri
        self.class.service_uri
      end

      # With no options, the default is to use the default site_id and the default
      # auth_token configured on the Api class.
      #   ebay = Ebay::Inventory::Api.new
      #
      # However, another user's auth_token can be used.
      #   ebay = Ebay::Inventory::Api.new(:auth_token => 'TEST')
      def initialize(options = {})
        @auth_token = options[:auth_token] || self.class.auth_token
      end

      private

      def commit(request_class, path, params)
        request = request_class.new(params)
        yield request if block_given?
        invoke(request, path)
      end

      def invoke(request, path)
        request_body = build_body(request)
        request_headers = build_headers(request.call_name)
        logger.info "Request sent: #{request_body}" if logger

        request_path = service_uri.path.chomp("/") + "/" + path

        # Inventory API uses 400 status code where trading API does not
        response =
          begin
            connection.post(request_path, request_body, request_headers)
          rescue ClientError => e
            if 400 == e.response.code.to_i
              e.response
            else
              raise
            end
          end

        decompressed_response = decompress(response)

        logger.info "Response received: #{decompressed_response}" if logger
        parse(decompressed_response)
      end

      def build_headers(call_name)
        {
          'Authorization' => "TOKEN #{auth_token}",
          'Content-Type' => 'application/xml',
          'Accept-Encoding' => 'gzip'
        }
      end

      def build_body(request)
        result = REXML::Document.new
        result << REXML::XMLDecl.new('1.0', 'UTF-8')
        result << request.save_to_xml
        result.to_s
      end

      def connection(refresh = false)
        @connection = Connection.new(service_uri) if refresh || @connection.nil?
        @connection
      end

      def decompress(response)
        case response['Content-Encoding']
        when 'gzip'
          gzr = Zlib::GzipReader.new(StringIO.new(response.body))
          decoded = gzr.read
          gzr.close
          decoded
        else
          response.body
        end
      end

      def parse(content)
        xml = REXML::Document.new(content)
        result = XML::Mapping.load_object_from_xml(xml.root)

        if [Ebay::Types::AckCode::Failure, Ebay::Types::AckCode::PartialFailure].include?(result.ack)
          raise RequestError.new(result.errors, result)
        end

        result
      end
    end
  end
end
