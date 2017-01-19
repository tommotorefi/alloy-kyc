$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'alloy/kyc'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures"
  c.hook_into :webmock
end

def create_evaluation
  VCR.use_cassette("get_bearer_token", record: :once, match_requests_on: [:host, :path]) do
    VCR.use_cassette("evaluation", record: :once, match_requests_on: [:host, :path]) do
      Alloy::KYC::Evaluation.create(
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
      )
    end
  end
end
