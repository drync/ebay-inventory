module Ebay # :nodoc:
  module InboundNotifications # :nodoc:
    module Types # :nodoc:
      class ReadyForPickup
        include XML::Mapping
        include Ebay::Initializer

        def type
          "EBAY.ORDER.READY_FOR_PICKUP"
        end

        root_element_name "payload"

        text_node :ebay_order_id, "ebayOrderId", :optional => false
        text_node :ebay_seller_id, "ebaySellerId", :optional => true
        text_node :notifier_pickup_note, "notifierPickupNode", :optional => true
        text_node :notifier_pickup_id, "notifierPickupId", :optional => true
      end
    end
  end
end
