require "faraday"
require "json"
require "base64"
require "ostruct"

require "alloy/kyc/version"
require "alloy/kyc/configuration"
require "alloy/kyc/bearer_token"
require "alloy/kyc/client"
require "alloy/kyc/evaluation"

module Alloy
  module KYC
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration) if block_given?
    end
  end
end
