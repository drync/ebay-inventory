require 'ebay/inventory/types'

module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Requests # :nodoc:
      class Abstract
        include XML::Mapping
        include Ebay::Initializer
        include Ebay::Inventory::Types

        root_element_name 'AbstractRequest'

        def call_name
          self.class.to_s.split('::').last.gsub(/Request$/, '')
        end
      end
    end
  end
end
