class FileSerializer < ActiveModel::Serializer
  attributes :id
  attribute :url

  def url
    object.url
  end
end