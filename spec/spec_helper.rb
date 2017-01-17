$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'alloy/kyc'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures"
  c.hook_into :webmock
end