module Ebay
  module InboundNotifications
    class Response
      include XML::Mapping
      include Ebay::Initializer

      root_element_name "inboundEventResponse"

      text_node :ack, 'ackValue'
      text_node :message, 'ackMessage', :optional => true

      def success?
        ack.upcase == 'SUCCESS'
      end

      def failure?
        !success?
      end
    end
  end
end
