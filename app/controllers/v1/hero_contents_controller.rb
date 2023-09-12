class V1::HeroContentsController < ApplicationController
  before_action :doorkeeper_authorize!, except: %i[ index show ]
  before_action :set_hero_content, only: %i[ show update destroy ]

  # GET /hero_contents
  def index
    @hero_content = HeroContent.first
    render json: serialize_hero_content(@hero_content)
  end

  # GET /hero_contents/1
  def show
    render json: serialize_hero_content(@hero_content)
  end

  # POST /hero_contents
  def create
    @hero_content = HeroContent.new(hero_content_params)

    if @hero_content.save
      render json: @hero_content, status: :created
    else
      render json: @hero_content.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hero_contents/1
  def update
    if @hero_content.update(hero_content_params)
      render json: @hero_content
    else
      render json: @hero_content.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hero_contents/1
  def destroy
    @hero_content.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hero_content
      @hero_content = HeroContent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hero_content_params
      params.require(:hero_content).permit(:button_text, :header_text, :href, hero_images: [])
    end

    # serialize hero content
    def serialize_hero_content(hero_content)
      V1::HeroContentSerializer.new(hero_content).serializable_hash[:data][:attributes]
    end
end
