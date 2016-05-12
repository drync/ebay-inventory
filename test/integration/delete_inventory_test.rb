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
      response = @ebay.delete_inventory(:sku => "", :locations => [ Location.new(:location_id => 'test') ])
      assert_equal true, response.failure?
      assert_equal nil, response.sku
      refute_empty response.errors.map(&:short_message).grep(/SKU/)
    end
  end

end
