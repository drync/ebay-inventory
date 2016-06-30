$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ebay/inventory'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

Ebay::Inventory::Api.configure do |config|
  config.use_sandbox = true
  config.auth_token = ENV['AUTH_TOKEN'] # Set to something when recording VCR requests
end

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('../fixtures/vcr', __FILE__)
  config.hook_into :webmock
  config.default_cassette_options = { :record => :new_episodes }
  config.filter_sensitive_data('<AUTH_TOKEN>') { ENV['AUTH_TOKEN'] } if ENV['AUTH_TOKEN']

  config.before_http_request(:real?) do |request|
    fail "Attempting to record an API call without an AUTH_TOKEN" unless ENV['AUTH_TOKEN']
  end
end

class Minitest::Test
  def capture_exception
    begin
      yield
      nil
    rescue => e
      e
    end
  end
end
