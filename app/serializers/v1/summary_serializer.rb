class V1::SummarySerializer
  include JSONAPI::Serializer

  set_type :summary
  set_id :id
  attributes :copy, :header, :id 

  attributes :bannerText do |object|
    object.banner_text
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
end