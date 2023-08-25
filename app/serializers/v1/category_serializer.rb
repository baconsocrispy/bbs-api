class V1::CategorySerializer
  include JSONAPI::Serializer
  attributes :id, :created_at, :name
end