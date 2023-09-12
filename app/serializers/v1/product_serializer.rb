class V1::ProductSerializer
  include JSONAPI::Serializer

  attributes :id, :created_at, :name, :short_description, :slug

  attributes :image do |object|
    image = object.default_image
    {
      byteSize: image.blob.byte_size,
      filename: image.blob.filename.to_s,
      id: image.blob.id,
      url: Rails.application.routes.url_helpers.rails_blob_url(image)
    }
  end

  attributes :images do |object|
    object.product_images.map do |image|
      {
        byteSize: image.blob.byte_size,
        filename: image.blob.filename.to_s,
        id: image.blob.id,
        url: Rails.application.routes.url_helpers.rails_blob_url(image)
      }
    end
  end
end