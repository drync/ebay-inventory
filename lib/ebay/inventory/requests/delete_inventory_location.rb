module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Requests # :nodoc:
      class DeleteInventoryLocation < Abstract
        include XML::Mapping
        include Ebay::Initializer

        root_element_name 'DeleteInventoryLocationRequest'
        text_node :location_id, 'LocationID', :optional => false
      end
    end
  end
end
