class V1::CategorySerializer
  include JSONAPI::Serializer

  set_type :category
  set_id :id
  attributes :id, :created_at, :name, :short_description, :slug

  attributes :products do |object|
    object.products.map { |product| 
      V1::ProductSerializer.new(product).serializable_hash[:data][:attributes]
    }
  end

  attributes :category_image do |object|
    image = object.category_image
    {
      byteSize: image.blob.byte_size,
      filename: image.blob.filename.to_s,
      id: image.blob.id,
      url: Rails.application.routes.url_helpers.rails_blob_url(image)
    }
  end
end