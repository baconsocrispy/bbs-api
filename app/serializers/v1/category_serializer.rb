class V1::CategorySerializer
  include JSONAPI::Serializer

  set_type :category
  set_id :id
  attributes :id, :created_at, :name, :short_description, :slug

  attributes :groups do |object|
    object.groups.map { |group| 
      V1::GroupSerializer.new(group).serializable_hash[:data][:attributes]
    }
  end

  attributes :image do |object|
    image = object.image
    {
      byteSize: image.blob.byte_size,
      filename: image.blob.filename.to_s,
      id: image.blob.id,
      url: Rails.application.routes.url_helpers.rails_blob_url(image)
    }
  end
end