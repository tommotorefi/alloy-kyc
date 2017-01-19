module Alloy
  module KYC
    module Client
      attr_reader :bearer_token

      def conn
        @conn ||= Faraday.new(url: "#{Alloy::KYC.configuration.api_endpoint}")
      end

      def get_bearer_token
        conn.basic_auth(Alloy::KYC.configuration.application_token, Alloy::KYC.configuration.application_secret)
        response = conn.post("/oauth/bearer")
        token_info = JSON.parse(response.body)
        @bearer_token = BearerToken.new(token_info["access_token"], token_info["expires_in"])
      end

      def requires_bearer_token?
        bearer_token.nil? || bearer_token.expired?
      end

      def set_auth_header
        if requires_bearer_token?
          conn.authorization("Bearer", get_bearer_token.token)
        end
      end

      def get(url, options={})
        set_auth_header
        conn.get(url, options)
      end

      def post(url, params={})
        set_auth_header
        conn.post(url, params)
      end

      def patch(url, params={})
        set_auth_header
        conn.patch(url, params)
      end

    end
  end
end
