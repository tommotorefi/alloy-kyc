# Alloy::Kyc

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/alloy/kyc`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qedinvestors/alloy-kyc.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
