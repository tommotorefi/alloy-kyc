require "faraday"
require "json"
require "base64"
require "ostruct"

require "alloy/kyc/version"
require "alloy/kyc/configuration"
require "alloy/kyc/bearer_token"
require "alloy/kyc/evaluation"
require 'alloy/kyc/backends/remote'
require 'alloy/kyc/backends/mock'

module Alloy
  module KYC
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration) if block_given?
    end

    def self.mock_mode!
      self.configuration.backend = Alloy::KYC::Backends::Mock.new
    end
  end
end
