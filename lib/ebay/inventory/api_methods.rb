require 'ebay/inventory/requests'

module Ebay # :nodoc:
  module Inventory # :nodoc:
    module ApiMethods

      def add_inventory_location(params = {})
        commit(Ebay::Inventory::Requests::AddInventoryLocation, "locations/delta/add", params)
      end

      def add_inventory(params = {})
        commit(Ebay::Inventory::Requests::AddInventory, "inventory/delta/add", params)
      end

      def delete_inventory_location(params = {})
        commit(Ebay::Inventory::Requests::DeleteInventoryLocation, "locations/delta/delete", params)
      end

      def delete_inventory(params = {})
        commit(Ebay::Inventory::Requests::DeleteInventory, "inventory/delta/delete", params)
      end

    end
  end
end
