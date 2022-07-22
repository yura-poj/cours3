# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < Api::V1::BaseController
      def me
        render json: current_resource_owner if doorkeeper_token
      end
    end
  end
end
