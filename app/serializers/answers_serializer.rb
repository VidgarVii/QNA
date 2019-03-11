class AnswersSerializer < ActiveModel::Serializer
  attributes %i[id body question_id created_at updated_at]
end
