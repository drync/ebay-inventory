module Ebay # :nodoc:
  module InboundNotifications # :nodoc:
    module Types # :nodoc:
      class PickupCanceled
        include XML::Mapping
        include Ebay::Initializer

        def type
          "EBAY.ORDER.PICKUP_CANCELED"
        end

        root_element_name "payload"

        text_node :ebay_order_id, "ebayOrderId", :optional => false
        text_node :ebay_seller_id, "ebaySellerId", :optional => true
        text_node :notifier_cancel_type, "notifierCancelType", :optional => false
        text_node :notifier_pickup_note, "notifierPickupNode", :optional => true
        text_node :notifier_pickup_id, "notifierPickupId", :optional => true
        text_node :notifier_refund_type, "notifierRefundType", :optional => false
      end
    end
  end
end
