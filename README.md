## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alloy-kyc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alloy-kyc

## Usage

Configure the gem using your issued Alloy credentials in an initializer file. For example, in config/initializers/alloy-kyc.rb:

```ruby
Alloy::KYC.configure do |config|
  config.application_token = ENV['ALLOY_APPLICATION_TOKEN']
  config.application_secret = ENV['ALLOY_APPLICATION_SECRET']
end
```

Create a new evaluation:

```ruby
Alloy::KYC::Evaluation.create({
    phone_number: "18042562188",
    name_first: "Thomas",
    name_last: "Nicholas",
    email_address: "tommy@alloy.co",
    birth_date: "1985-01-23",
    address_line_1: "1717 E Test St",
    address_city: "Richmond",
    address_state: "VA",
    document_ssn: "123456789",
    address_postal_code: "23220",
    address_country_code: "US",
    social_twitter: "tommyrva"
  })
```

If evaluation requires further information around out-of-wallet questions:

```ruby
evaluation = Alloy::KYC::Evaluation.create({phone_number: "18042562188", name_first: "Thomas",...})
if evaluation.requires_oow?
  # collect answers and either match locally or resubmit
  updated_evaluation = evaluation.submit_oow_responses(responses)
end
```

## Testing

To prevent this gem from making API calls when your tests are running, use mock mode:

```ruby
Alloy::KYC.mock_mode!
```

When in mock mode methods will return "successful" results; i.e., a call to `Alloy::KYC::Evaluation.create` will return an `Evaluation` that doesn't require an out of wallet followup. To simulate a failure, call `Alloy::KYC::Evaluation.create` with a `document_ssn` of `111223333`:

```ruby
Alloy::KYC::Evaluation.create(document_ssn: "111223333", ...) # any other parameters are ignored
```

Similarly, you can simulate an out-of-wallet response that requires more responses by passing that same `document_ssn` to `submit_oow_responses`:

```ruby
# given an existing Evaluation e:
e.submit_oow_responses({document_ssn: "111223333", ...}) # any other parameters are ignored
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qedinvestors/alloy-kyc.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
