class V1::SpecSerializer
  include JSONAPI::Serializer

  set_type :spec
  set_id :id
  attributes :created_at, :category, :id, :product_id, :text
end