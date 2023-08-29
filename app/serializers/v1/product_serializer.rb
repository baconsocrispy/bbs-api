class V1::ProductSerializer
  include JSONAPI::Serializer
  attributes :id, :created_at, :name, :short_description
end