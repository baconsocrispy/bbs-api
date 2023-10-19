class V1::GroupsController < ApplicationController
  before_action :doorkeeper_authorize!, except: %i[ index show ]
  before_action :set_group, only: %i[ show update destroy ]

  # GET /groups
  def index
    @groups = Group.all

    render json: {
      groups: @groups.map { |group| 
        serialize_group(group)
      }
    }, status: :ok
  end

  # GET /groups/1
  def show
    render json: serialize_group(@group)
  end

  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      render json: serialize_group(@group), status: :created
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      render json: serialize_group(@group)
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find_by(slug: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group)
            .permit(:name, 
                    :short_description, 
                    :category_id, 
                    :group_image, 
                    :banner_image
                  )
    end

    # serialize group
    def serialize_group(group)
      V1::GroupSerializer.new(group).serializable_hash[:data][:attributes]
    end
end
