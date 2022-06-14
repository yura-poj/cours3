# frozen_string_literal: true

class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validate :check_url

  def check_url
    begin
      URI.open(self.url).status.first == '200'
    rescue SocketError, Errno::ENOENT
      errors.add(:url, 'is not valid')
    end
  end
end
