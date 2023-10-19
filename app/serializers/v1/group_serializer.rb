class V1::GroupSerializer
  include JSONAPI::Serializer

  set_type :group
  set_id :id
  attributes :id, :name, :short_description, :slug

  attributes :createdAt do |object|
    object.created_at
  end

  attributes :categoryId do |object|
    object.category_id
  end

  attributes :image do |object|
    image = object.group_image
    if image.present?
      {
        byteSize: image.blob.byte_size,
        filename: image.blob.filename.to_s,
        id: image.blob.id,
        url: Rails.application.routes.url_helpers.rails_blob_url(image)
      }
    end
  end

  attributes :banner do |object|
    image = object.banner_image
    if image.present?
      {
        byteSize: image.blob.byte_size,
        filename: image.blob.filename.to_s,
        id: image.blob.id,
        url: Rails.application.routes.url_helpers.rails_blob_url(image)
      }
    end
  end

  attributes :products do |object|
    object.products.map { |product|
      V1::ProductSerializer.new(product).serializable_hash[:data][:attributes]
    }
  end
end