module Alloy
  module KYC
    class BearerToken
      attr_accessor :token, :expires_at

      def initialize(access_token, expires_in)
        @token = access_token
        @expires_at = Time.now + expires_in
      end

      def expired?
        Time.now > expires_at
      end
    end
  end
end
