class V1::ProductsController < ApplicationController
  before_action :doorkeeper_authorize!, except: %i[ index show ]
  before_action :set_product, only: %i[ show update destroy ]

  # GET /products
  def index
    @products = Product.all.with_attached_product_images

    render json: {
      products: @products.map { |product|
        serialize_product(product)
      }, status: :ok
    }
  end

  # GET /products/1
  def show
    if @product.present?
      render json: serialize_product(@product), include: [ :product_images ]
    else
      render json: { message: 'Product does not exist' }, status: :unprocessable_entity
    end
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save!
      render json: serialize_product(@product), status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: serialize_product(@product)
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find_by(slug: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(
        :default_image,
        :features_header,
        :highlight,
        :name,
        :slug,
        :short_description,
        product_images: [],
        features_attributes: [ :id, :highlight, :text, :_destroy ],
        product_groupings_attributes: [ :id, :group_id, :product_id, :_destroy ],
        specs_attributes: [ :id, :category, :text, :_destroy ],
        text_blocks_attributes: [ :id, :text, :title, :_destroy ]
      )
    end

    # serialize product
    def serialize_product(product)
      V1::ProductSerializer.new(product).serializable_hash[:data][:attributes]
    end
end
