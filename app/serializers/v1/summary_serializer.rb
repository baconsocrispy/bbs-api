class V1::SummarySerializer
  include JSONAPI::Serializer

  set_type :summary
  set_id :id
  attributes :id, :copy, :header
end