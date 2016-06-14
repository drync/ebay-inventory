require "ebay/inbound_notifications/types"

module Ebay # :nodoc:
  module InboundNotifications # :nodoc:
    class Request < Inventory::Requests::Abstract      
      root_element_name 'event'

      text_node :version, "version", :required => true
      text_node :type, "type", :required => true
      text_node :notifier_reference_id, "notifierReferenceId", :required => true
      object_node :payload, "payload", :required => true
    end
  end
end
