# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :set_link

  authorize_resource

  def destroy
    @record = @link.linkable
    respond_to do |format|
      @link.destroy
      flash.now[:success] = 'Your link successfully deleted'
      format.turbo_stream { render "shared/#{@record.class.to_s.downcase}_update" }
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end
end
