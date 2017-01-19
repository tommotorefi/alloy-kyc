module Alloy
  module KYC
    class Configuration
      attr_accessor :application_token
      attr_accessor :application_secret
      attr_accessor :api_endpoint

      def initialize
        @application_token = "dpDD6z4olOSI7N4fMCsAlKjFa7reBYhu"
        @application_secret = "oJm3niQX1Pdy4z675kefEIKBgFn9tQ45"
        @api_endpoint = "https://sandbox.alloy.co/v1"
      end
    end
  end
end
