class V1::CategoriesController < ApplicationController
  before_action :doorkeeper_authorize!, except: %i[ index show ]
  before_action :set_category, only: %i[ show update destroy ]

  # GET /categories
  def index
    @categories = Category.in_order
    render json: {
      categories: @categories.map { |category| 
        serialize_category(category)
      }
    }, status: :ok
  end

  # GET /categories/1
  def show
    render json: serialize_category(@category)
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: serialize_category(@category), status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: serialize_category(@category)
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private
    # Find and set category by slug
    def set_category
      @category = Category.find_by(slug: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, 
                                       :short_description, 
                                       :tag_line, 
                                       :title, 
                                       :banner_image, 
                                       :category_image, 
                                       :pinned_image 
                                      )
    end

    # serialize response
    def serialize_category(category)
      V1::CategorySerializer.new(category).serializable_hash[:data][:attributes]
    end
end
