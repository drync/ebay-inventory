module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Responses # :nodoc:
      class DeleteInventory < Abstract
        include XML::Mapping
        include Ebay::Initializer
        root_element_name 'DeleteInventoryResponse'
        text_node :sku, 'SKU', :optional => true
      end
    end
  end
end
