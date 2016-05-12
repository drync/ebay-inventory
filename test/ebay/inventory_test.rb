require 'test_helper'

class Ebay::InventoryTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ebay::Inventory::VERSION
  end
end
