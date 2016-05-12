require 'test_helper'

class AddInventoryTest < Minitest::Test
  include Ebay::Inventory::Types

  def setup
    @location_attributes = {
      :location_id => 'test',
      :quantity => 5,
      :availability => 'IN_STOCK'
    }

    @ebay = Ebay::Inventory::Api.new
  end

  def test_valid_request
    VCR.use_cassette("add_inventory") do
      response = @ebay.add_inventory(
        :sku => "123",
        :locations => [ Location.new(@location_attributes) ])

      assert_instance_of Ebay::Inventory::Responses::AddInventory, response
      assert_equal true, response.success?
      assert_equal "123", response.sku
    end
  end

  def test_invalid_request
    VCR.use_cassette("add_inventory-invalid") do
      response = @ebay.add_inventory(:sku => "123", :locations => [])
      assert_equal true, response.failure?
      assert_equal nil, response.sku
      refute_empty response.errors.map(&:short_message).grep(/Locations/)
    end
  end

end
