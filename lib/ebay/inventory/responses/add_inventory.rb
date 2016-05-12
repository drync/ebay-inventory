module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Responses # :nodoc:
      class AddInventory < Abstract
        include XML::Mapping
        include Ebay::Initializer
        root_element_name 'AddInventoryResponse'
        text_node :sku, 'SKU', :optional => true
      end
    end
  end
end
