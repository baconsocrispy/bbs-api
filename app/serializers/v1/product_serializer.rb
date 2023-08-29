class V1::ProductSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :created_at, :name, :product_images, :short_description

  def product_images
    return unless object.product_images.attached?

    object.product_images.map do |image|
      image.blob.attributes
        .slice('filename', 'byte_size', 'id')
        .merge(url: product_image_url(image))
    end
  end

  def product_image_url(image)
    rails_blob_path(image, only_path: true)
  end
end