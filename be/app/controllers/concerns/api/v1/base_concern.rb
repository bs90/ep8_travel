module Api::V1::BaseConcern
  extend ActiveSupport::Concern
  include Api::V1::RescueExceptions
  include Api::V1::Authenticable
  include Api::V1::Pagination
end
