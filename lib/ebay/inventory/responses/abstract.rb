require 'ebay/types/error'
require 'ebay/inventory/responses/base'
require 'ebay/inventory/types'

module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Responses # :nodoc:
      class Abstract < Base
        include XML::Mapping
        include Ebay::Initializer
        include Ebay::Inventory::Types
        
        root_element_name 'AbstractResponse'
        text_node :ack, 'Ack'
        array_node :errors, 'Errors', :class => Ebay::Types::Error, :default_value => []
      end
    end
  end
end
