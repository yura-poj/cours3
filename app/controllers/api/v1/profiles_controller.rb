class Api::V1::ProfilesController < Api::V1::BaseController

  def me
    render json: current_resource_owner if doorkeeper_token
  end

  private


end
