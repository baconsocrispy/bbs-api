class V1::FeatureSerializer
  include JSONAPI::Serializer

  set_type :hero_content
  set_id :id
  attributes :created_at, :highlight, :id, :order, :product_id, :text
end