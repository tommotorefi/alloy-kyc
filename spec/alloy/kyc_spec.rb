require 'spec_helper'

describe Alloy::KYC do

  describe "version" do
    it 'has a version number' do
      expect(Alloy::KYC::VERSION).not_to be nil
    end
  end

  describe "#configure" do
    before do
      Alloy::KYC.configure do |config|
        config.application_token = "45432c33e1392dc6263ac8bcce491d2e"
        config.application_secret = "4f247d0645f9e94b9e83621bd71dc294"
      end
    end

    it "sets the configuration correctly" do
      expect(Alloy::KYC.configuration.application_token).to eq("45432c33e1392dc6263ac8bcce491d2e")
      expect(Alloy::KYC.configuration.application_secret).to eq("4f247d0645f9e94b9e83621bd71dc294")
    end
  end

end
