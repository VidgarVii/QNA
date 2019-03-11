class AnswerSerializer < ActiveModel::Serializer
  attributes %i[id body question_id created_at short_body updated_at files]
  has_many :links
  has_many :comments


  def short_body
    object.body.truncate(7)
  end

  def files
    object.files.map { |file| Rails.application.routes.url_helpers.rails_blob_url(file) }
  end
end
