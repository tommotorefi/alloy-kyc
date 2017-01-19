module Alloy
  module KYC
    class Evaluation < OpenStruct
      extend Client

      def self.create(params)
        response = post("/evaluations", params)
        new(JSON.parse(response.body))
      end

      def initialize(response)
        super(response)
        self.raw_response = response
      end

      def success?
        summary["result"] == "success" && status_code != 206
      end

      def partial_success?
        summary["result"] == "success" && status_code == 206
      end

      def requires_oow?
        !!self.required
      end

      # responses should be in the format:
      # {answers: [
      #   {question_id: 1, answer_id: 2},
      #   {question_id: 2, answer_id: 4},
      #   ....
      # ],
      # name_first: "Charles",
      # name_last: "Hearn"}
      def submit_oow_responses(responses)
        response = self.class.patch("/evaluations/#{self.evaluation_token}", responses)
        self.class.new(JSON.parse(response.body))
      end

      def fork
        response = self.class.post("/evaluations/#{self.evaluation_token}")
        self.class.new(JSON.parse(response.body))
      end

    end
  end
end
