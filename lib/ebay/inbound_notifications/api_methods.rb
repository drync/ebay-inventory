require 'ebay/inbound_notifications/request'

module Ebay
  module InboundNotifications
    module ApiMethods
      def publish_event(params)
        if payload = params[:payload]
          type = payload.type
        end

        commit(Ebay::InboundNotifications::Request, "InboundEvent/publish", { type: type }.merge(params))
      end
    end
  end
end
