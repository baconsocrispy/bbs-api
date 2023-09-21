class V1::TextBlockSerializer
  include JSONAPI::Serializer

  set_type :text_block
  set_id :id
  attributes :created_at, :id, :product_id, :text, :title
end