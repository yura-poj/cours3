class LinksController < ApplicationController
  before_action :set_link

  def destroy
    @record = @link.linkable
    respond_to do |format|
      if @record.author?(current_user)
        @link.destroy
        flash.now[:success] = 'Your link successfully deleted'
        format.turbo_stream { render "shared/#{@record.class.to_s.downcase}_update" }
      else
        format.html { redirect_back fallback_location: root_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end
end
