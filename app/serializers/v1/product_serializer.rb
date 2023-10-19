class V1::ProductSerializer
  include JSONAPI::Serializer

  attributes :id, :created_at, :highlight, :name, :short_description, :slug

  attributes :featuresHeader do |object|
    object.features_header
  end
  
  attributes :features do |object|
    object.features.map { |feature|
      V1::FeatureSerializer.new(feature).serializable_hash[:data][:attributes]
    }
  end

  attributes :productGroupings do |object|
    object.product_groupings.map { |product_grouping|
      V1::ProductGroupingSerializer.new(product_grouping).serializable_hash[:data][:attributes]
    }
  end

  attributes :image do |object|
    image = object.default_image
    if image.present?
      {
        byteSize: image.blob.byte_size,
        filename: image.blob.filename.to_s,
        id: image.blob.id,
        url: Rails.application.routes.url_helpers.rails_blob_url(image)
      }
    end
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

  attributes :specs do |object|
    object.specs.map { |spec|
      V1::SpecSerializer.new(spec).serializable_hash[:data][:attributes]
    }
  end

  attributes :textBlocks do |object|
    object.text_blocks.map { |text_block|
      V1::TextBlockSerializer.new(text_block).serializable_hash[:data][:attributes]
    }
  end
end