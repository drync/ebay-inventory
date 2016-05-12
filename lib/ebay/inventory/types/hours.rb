require 'ebay/inventory/types/interval'

module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Types # :nodoc:
      class Hours
        include XML::Mapping
        include Ebay::Initializer

        root_element_name 'Day'

        # One or the other is required
        text_node :day_of_week, 'DayOfWeek', :optional => true
        text_node :date, 'Date', :optional => true

        object_node :interval, 'Interval', :class => Types::Interval, :optional => false
      end
    end
  end
end
