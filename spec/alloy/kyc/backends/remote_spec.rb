require 'spec_helper'

describe Alloy::KYC::Backends::Remote do

  before do
    Alloy::KYC.configure
  end

  describe "#conn" do
    it "should return a new connection" do
      VCR.use_cassette("get_bearer_token", record: :once, match_requests_on: [:host, :path]) do
        connection = subject.conn
        expect(connection).to be
      end
    end
  end

  describe "#get_bearer_token" do
    it "should return a new BearerToken" do
      VCR.use_cassette("get_bearer_token") do
        bearer_token = subject.get_bearer_token
        expect(bearer_token.token).to be
        expect(bearer_token.expires_at).to be
      end
    end
  end

end
