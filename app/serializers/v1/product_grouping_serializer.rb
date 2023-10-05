class V1::ProductGroupingSerializer
  include JSONAPI::Serializer

  set_type :product_grouping
  set_id :id
  attributes :created_at, :group_id, :id, :product_id
end