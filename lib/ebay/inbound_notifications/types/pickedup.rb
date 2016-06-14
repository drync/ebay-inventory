module Ebay # :nodoc:
  module InboundNotifications # :nodoc:
    module Types # :nodoc:
      class Pickedup
        include XML::Mapping
        include Ebay::Initializer

        def type
          "EBAY.ORDER.PICKEDUP"
        end

        root_element_name "payload"

        text_node :ebay_order_id, "ebayOrderId", :optional => false
        text_node :ebay_seller_id, "ebaySellerId", :optional => true
      end
    end
  end
end
