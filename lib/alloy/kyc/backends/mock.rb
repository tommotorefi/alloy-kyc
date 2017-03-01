module Alloy

  module KYC

    module Backends

      class Mock

        attr_accessor :bearer_token, :database

        def initialize
          @database = generate_fake_data
          nil
        end

        def get_bearer_token
          @bearer_token = BearerToken.new("access_token", Time.now + (60*60*24*365))
        end

        def requires_bearer_token?
          bearer_token.nil? || bearer_token.expired?
        end

        def create_evaluation(params)
          if !params[:document_ssn].nil? && params[:document_ssn] == "111223333"
            wrap_in_struct(database[:create_evaluations][:requires_oow])
          else
            wrap_in_struct(database[:create_evaluations][:success])
          end
        end

        def submit_oow_responses(path, responses)
          if responses[:document_ssn] == "111223333"
            wrap_in_struct(database[:submit_oow_responses][:requires_oow])
          else
            wrap_in_struct(database[:submit_oow_responses][:success])
          end
        end

        def fork_evaluation(path)
          wrap_in_struct(database[:fork_evaluation][:success])
        end

        private

        def wrap_in_struct(hash)
          json = hash.to_json
          OpenStruct.new(raw_response: json, body: json)
        end

        def generate_fake_data
          {
            create_evaluations: {
              success: fake_create_evaluations_response_success,
              requires_oow: fake_create_evaluations_response_requires_oow
            },
            submit_oow_responses: {
              success: fake_create_evaluations_response_success,
              requires_oow: fake_create_evaluations_response_requires_oow
            },
            fork_evaluation: {
              success: fake_fork_response_success
            }
          }
        end

        def fake_fork_response_success
          load_mock_data("fake_fork_response_success.json")
        end

        def fake_create_evaluations_response_requires_oow
          load_mock_data("fake_create_evaluations_response_requires_oow.json")
        end

        def fake_create_evaluations_response_success
          load_mock_data("fake_create_evaluations_response_success.json")
        end

        def load_mock_data(filename)
          # Would use Gem.datadir, but https://github.com/rubygems/rubygems/issues/1673
          JSON.parse(File.read(Gem.loaded_specs['alloy-kyc'].full_gem_path + "/data/#{filename}"))
        end

      end

    end

  end

end
