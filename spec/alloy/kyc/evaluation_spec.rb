require 'spec_helper'

describe Alloy::KYC::Evaluation do

  before(:each) { Alloy::KYC.configure }

  describe ".create" do
    it "should return a valid response" do
      evaluation = create_evaluation

      expect(evaluation.status_code).to eq(201)
      expect(evaluation.error).to be_nil
    end
  end

  describe "#success?" do
    it "should return true if summary result == 'success' and status_code is not 206" do
      evaluation = create_evaluation
      expect(evaluation.summary["result"]).to eq("success")
      expect(evaluation.status_code).to eq(201)
      expect(evaluation.success?).to eq(true)
    end
  end

  describe "#partial_success?" do
    it "should return true if summary result == 'success' and status_code is 206" do
      evaluation = create_evaluation
      evaluation.status_code = 206
      expect(evaluation.summary["result"]).to eq("success")
      expect(evaluation.status_code).to eq(206)
      expect(evaluation.partial_success?).to eq(true)
    end
  end

  describe "#requires_oow?" do
    it "should provide required info" do
      VCR.use_cassette("get_bearer_token", record: :once) do
        VCR.use_cassette("oow_evaluation", record: :once) do
          evaluation = Alloy::KYC::Evaluation.create(
            phone_number: "8005551212",
            name_first: "John",
            name_last: "Doe",
            birth_date: "1985-01-01",
            document_ssn: "123456789",
            address_line_1: "1717 E Test St",
            address_city: "Washington",
            address_state: "DC",
            address_postal_code: "20005",
            address_country_code: "US"
          )
          expect(evaluation.required.length).to be > 0
          expect(evaluation.requires_oow?).to be(true)
        end
      end

    end
  end

  describe "#submit_oow_responses" do
    it "should return a new updated evaluation with same evaluation_token" do
      evaluation = create_evaluation
      responses = {
        name_first: "Charles",
        name_last: "Hearn",
        answers:[
          {question_id: 1, answer_id: 1},
          {question_id: 2, answer_id: 5},
          {question_id: 3, answer_id: 2},
          {question_id: 4, answer_id: 1},
          {question_id: 5, answer_id: 5}
        ]
      }
      VCR.use_cassette("get_bearer_token", record: :once) do
        VCR.use_cassette("submit_oow_responses", record: :once, match_requests_on: [:host, :path]) do
          new_evaluation = evaluation.submit_oow_responses(responses)
          expect(new_evaluation.evaluation_token).to eq(evaluation.evaluation_token)
        end
      end
    end
  end

  describe "#fork" do
    it "should return new evaluation" do
      evaluation = create_evaluation
      VCR.use_cassette("get_bearer_token", record: :once) do
        VCR.use_cassette("fork_evaluation", record: :once, match_requests_on: [:host, :path]) do
          new_evaluation = evaluation.fork
          expect(evaluation.evaluation_token).to_not eq(new_evaluation.evaluation_token)
        end
      end
    end
  end

end
