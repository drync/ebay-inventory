require 'ebay/inventory/types/hours'

module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Requests # :nodoc:
      class AddInventoryLocation < Abstract
        include XML::Mapping
        include Ebay::Initializer

        root_element_name 'AddInventoryLocationRequest'

        text_node :address1, 'Address1', :optional => false
        text_node :address2, 'Address2', :optional => true
        text_node :city, 'City', :optional => false
        text_node :country, 'Country', :optional => false
        array_node :hours, 'Hours', 'Day', :class => Hours, :optional => false
        text_node :latitude, 'Latitude', :optional => false
        text_node :longitude, 'Longitude', :optional => false
        text_node :location_id, 'LocationID', :optional => false
        text_node :location_type, 'LocationType', :optional => true
        text_node :name, 'Name', :optional => false
        text_node :phone, 'Phone', :optional => false
        text_node :pickup_instructions, 'PickupInstructions', :optional => true
        text_node :postal_code, 'PostalCode', :optional => false
        text_node :region, 'Region', :optional => false
        array_node :special_hours, 'SpecialHours', 'Day', :class => Hours, :optional => true, :default => []
        text_node :url, 'URL', :optional => true
        text_node :utc_offset, 'UTCOffset', :optional => false
      end
    end
  end
end
