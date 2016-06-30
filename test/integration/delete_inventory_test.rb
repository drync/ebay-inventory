require 'test_helper'

class DeleteInventoryTest < Minitest::Test
  include Ebay::Inventory::Types

  def setup
    @ebay = Ebay::Inventory::Api.new
  end

  def test_valid_request
    VCR.use_cassette("delete_inventory") do
      response = @ebay.delete_inventory(
        :sku => "123",
        :locations => [ Location.new(:location_id => 'test') ])

      assert_instance_of Ebay::Inventory::Responses::DeleteInventory, response
      assert_equal true, response.success?
      assert_equal "123", response.sku
    end
  end

  def test_invalid_request
    VCR.use_cassette("delete_inventory-invalid") do
      error = capture_exception { @ebay.delete_inventory(:sku => "", :locations => [ Location.new(:location_id => 'test') ]) }
      assert_instance_of Ebay::RequestError, error

      assert_equal nil, error.result.sku
      refute_empty error.result.errors.map(&:short_message).grep(/SKU/)
    end
  end

end
