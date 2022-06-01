# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :set_file

  def destroy
    @record = @file.record
    respond_to do |format|
      if @record.author?(current_user)
        @file.purge
        flash.now[:success] = 'Your file successfully deleted'
        format.turbo_stream { render "#{@record.class.to_s.downcase}_update" }
      else
        format.html { redirect_back fallback_location: root_path, status: :unprocessable_entity }
      end
    end
  end

  def set_file
    @file = ActiveStorage::Attachment.find(params[:id])
  end
end
