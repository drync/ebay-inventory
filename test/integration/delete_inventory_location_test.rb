require 'test_helper'

class DeleteInventoryLocationTest < Minitest::Test
  include Ebay::Inventory::Types

  def setup
    @ebay = Ebay::Inventory::Api.new
  end

  def test_valid_request
    VCR.use_cassette("delete_inventory_location") do
      response = @ebay.delete_inventory_location(:location_id => 'test')
      assert_instance_of Ebay::Inventory::Responses::DeleteInventoryLocation, response
      assert_equal true, response.success?
      assert_equal "TEST", response.location_id
    end
  end

  def test_invalid_request
    VCR.use_cassette("delete_inventory_location-invalid") do
      response = @ebay.delete_inventory_location(:location_id => 'zzzz')
      assert_equal true, response.failure?
      refute_empty response.errors.map(&:short_message).grep(/Location does not exist/)
    end
  end

end
