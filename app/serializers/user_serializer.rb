class UserSerializer < ActiveModel::Serializer
  attributes %i[id email created_at updated_at admin]
end
