class V1::CategorySerializer
  include JSONAPI::Serializer

  set_type :category
  set_id :id
  attributes :id, :created_at, :name, :short_description, :slug, :title

  # format for frontend
  attributes :tagLine do |object|
    object.tag_line
  end

  # associations
  attributes :groups do |object|
    object.groups.in_order.map { |group| 
      V1::GroupSerializer.new(group).serializable_hash[:data][:attributes]
    }
  end

  # image configuration
  attributes :image do |object|
    image = object.category_image
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

  attributes :pinned do |object|
    image = object.pinned_image
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