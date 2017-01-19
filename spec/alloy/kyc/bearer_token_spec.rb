require 'spec_helper'

describe Alloy::KYC::BearerToken do
  let!(:bearer_token) { Alloy::KYC::BearerToken.new("7a62498f88e1d42181601d471fa08c02", 3600) }

  describe "new token" do

    it "should have a token value" do
      expect(bearer_token.token).to eq("7a62498f88e1d42181601d471fa08c02")
    end

    it "should not be expired" do
      expect(bearer_token.expired?).to be(false)
    end

  end
end
