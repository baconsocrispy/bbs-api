class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :created_at, :email, :first_name, :last_name
end