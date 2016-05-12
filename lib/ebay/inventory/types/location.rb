module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Types # :nodoc:
      class Location
        include XML::Mapping
        include Initializer

        root_element_name 'Location'
        text_node :availability, 'Availability', :optional => true
        text_node :fulfillment_time, 'FulfillmentTime', :optional => true
        text_node :location_id, 'LocationID', :optional => false
        numeric_node :quantity, 'Quantity', :optional => true
      end
    end
  end
end
