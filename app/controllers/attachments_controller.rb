# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :set_file

  authorize_resource

  def destroy
    @record = @file.record
    respond_to do |format|
      @file.purge
      flash.now[:success] = 'Your file successfully deleted'
      format.turbo_stream { render "shared/#{@record.class.to_s.downcase}_update" }
    end
  end

  private

  def set_file
    @file = ActiveStorage::Attachment.find(params[:id])
  end
end
