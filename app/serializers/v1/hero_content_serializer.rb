class V1::HeroContentSerializer
  include JSONAPI::Serializer

  set_type :hero_content
  set_id :id
  attributes :id, :created_at, :button_text, :header_text, :href

  attributes :images do |object|
    object.hero_images.map { |image|
      {
        byteSize: image.blob.byte_size,
        filename: image.blob.filename.to_s,
        id: image.blob.id,
        url: Rails.application.routes.url_helpers.rails_blob_url(image)
      }
    }
  end
end