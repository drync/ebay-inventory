module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Responses # :nodoc:
      class DeleteInventoryLocation < Abstract
        include XML::Mapping
        include Ebay::Initializer
        root_element_name 'DeleteInventoryLocationResponse'
        text_node :location_id, 'LocationID', :optional => true
      end
    end
  end
end
