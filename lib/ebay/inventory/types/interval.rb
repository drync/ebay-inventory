module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Types # :nodoc:
      class Interval
        include XML::Mapping
        include Ebay::Initializer

        root_element_name 'Interval'
        text_node :open, 'Open', :optional => false
        text_node :close, 'Close', :optional => false
      end
    end
  end
end
