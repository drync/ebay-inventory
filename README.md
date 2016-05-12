# Ebay::Inventory

eBay Inventory Management API client.

Rides sidecar to the Trading API client and adds support for inventory functions
related to in-store pickup.

http://developer.ebay.com/DevZone/store-pickup/InventoryManagement/index.html

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ebay-inventory'
```

Because the original ebay client gem is abandoned you'll need to add a compatible fork to your Gemfile:

```ruby
gem 'ebayapi', :github => 'drync/ebay'
```

And then execute:

    $ bundle

## Usage

Configure the api client with an authentication token and enable sandbox if not running in production.

```ruby
Ebay::Inventory::Api.configure do |config|
  config.auth_token = ...
  config.use_sandbox = true    # defaults to production
end
```

API methods are called on a client instance.

```ruby
ebay = Ebay::Inventory::Api.new
ebay.add_inventory_location(...)
ebay.add_inventory(...)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/drync/ebay-inventory.

## License

Usable under the terms of the MIT license.

## Credits

Based on ebay Trading API client code by Cody Fauser and others, their work used under the
terms of the MIT license.
