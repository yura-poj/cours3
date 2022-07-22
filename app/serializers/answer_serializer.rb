# frozen_string_literal: true

class AnswerSerializer < ActiveModel::Serializer
  attributes %i[id body question_id created_at updated_at]
  belongs_to :author
  has_many :links
  has_many :files, serializer: FileSerializer
end
