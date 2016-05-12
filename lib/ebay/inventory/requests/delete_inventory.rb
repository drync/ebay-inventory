module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Requests # :nodoc:
      class DeleteInventory < Abstract
        include XML::Mapping
        include Ebay::Initializer

        root_element_name 'DeleteInventoryRequest'
        text_node :sku, 'SKU', :optional => false
        array_node :locations, 'Locations', 'Location', :class => Location, :optional => false
      end
    end
  end
end
