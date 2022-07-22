# frozen_string_literal: true

class QuestionSerializer < ActiveModel::Serializer
  attributes %i[id title body created_at updated_at]
  belongs_to :author
  has_many :links
  has_many :files, serializer: FileSerializer
  has_one :reward
end
