module Api
  module V1
    module RescueExceptions
      extend ActiveSupport::Concern
      included do
        rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
        rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
        rescue_from Errors::Api::Unauthenticated, with: :render_unauthenticated_response
        rescue_from Errors::Api::Unauthorized, with: :render_unauthorized_response

        protected

        def render_unprocessable_entity_response(error, status: :unprocessable_entity)
          render json: Errors::ActiveRecord::Validation.new(error.record).to_hash, status:
        end

        def render_record_not_found_response(error, status: :not_found)
          render json: Errors::ActiveRecord::NotFound.new(error).to_hash, status:
        end

        def render_unauthenticated_response(error, status: :unauthorized)
          render json: error.to_hash, status:
        end

        def render_unauthorized_response(error, status: :unauthorized)
          render json: error.to_hash, status:
        end
      end
    end
  end
end
