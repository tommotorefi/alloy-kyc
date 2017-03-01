require 'spec_helper'

describe Alloy::KYC::Backends::Mock do

  describe '#create_evaluation' do

    it 'returns a successful evaluation' do
      expect(JSON.parse(subject.create_evaluation({}).body)).not_to have_key("required")
    end

    it 'returns an oow evaluation if appropriate document_ssn is passed in' do
      expect(JSON.parse(subject.create_evaluation({document_ssn: "111223333"}).body)).to have_key("required")
    end

  end

  describe '#submit_oow_responses' do

    it 'returns a successful response' do
      expect(JSON.parse(subject.submit_oow_responses("", {}).body)).not_to have_key("required")
    end

    it 'returns an oow if appropriate document ssn is passed in' do
      expect(JSON.parse(subject.submit_oow_responses("", {document_ssn: "111223333"}).body)).to have_key("required")
    end

  end

  describe '#fork_evaluation' do

    it 'returns a successful response' do
      expect(JSON.parse(subject.fork_evaluation("").body)).not_to have_key("required")
    end

  end

end
