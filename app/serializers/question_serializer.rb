class QuestionSerializer < ActiveModel::Serializer
  attributes %i[id title body created_at updated_at short_title files]
  has_many :links
  has_many :comments


  def short_title
    object.title.truncate(7)
  end

  def files
    object.files.map { |file| Rails.application.routes.url_helpers.rails_blob_url(file) }
  end
end