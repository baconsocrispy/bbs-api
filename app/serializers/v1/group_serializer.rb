class V1::GroupSerializer
  include JSONAPI::Serializer

  set_type :group
  set_id :id
  attributes :id, :created_at, :name, :short_description, :slug

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
end