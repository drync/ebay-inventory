require 'test_helper'

class AddInventoryLocationTest < Minitest::Test
  include Ebay::Inventory::Types

  def setup
    @location_attributes = {
      :location_id => "test", :address1 => "1 Anywhere St", :city => 'Somerville',
      :region => 'MA', :country => 'US',
      :hours => [
        Hours.new(:day_of_week => 1, :interval => Interval.new(:open => "08:00:00", :close => "19:00:00"))
      ],
      :utc_offset => "-05:00",
      :latitude => "42.394598",
      :longitude => "-71.121187",
      :name => "Joes Liquor Barn",
      :phone => '617-555-1111',
      :postal_code => '02144'
    }

    @ebay = Ebay::Inventory::Api.new
  end

  def test_valid_request
    VCR.use_cassette("add_inventory_location") do
      response = @ebay.add_inventory_location(@location_attributes)

      assert_instance_of Ebay::Inventory::Responses::AddInventoryLocation, response
      assert_equal true, response.success?
      assert_equal @location_attributes[:location_id].upcase, response.location_id
    end
  end

  def test_invalid_request
    VCR.use_cassette("add_inventory_location-invalid") do
      error = capture_exception { @ebay.add_inventory_location(@location_attributes.merge(:name => '')) }
      assert_instance_of Ebay::RequestError, error

      assert_equal nil, error.result.location_id
      refute_empty error.result.errors.map(&:short_message).grep(/name/i)
    end
  end

end
