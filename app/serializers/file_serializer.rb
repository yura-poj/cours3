# frozen_string_literal: true

class FileSerializer < ActiveModel::Serializer
  attributes :id
  attribute :url

  delegate :url, to: :object
end
