class V1::CategorySerializer
  include JSONAPI::Serializer

  set_type :category
  set_id :id
  attributes :id, :created_at, :name

  attributes :products do |object|
    object.products.map { |product| 
      ProductSerializer.new(product).serializable_hash[:data][:attributes]
    }
  end
end