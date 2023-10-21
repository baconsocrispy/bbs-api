class V1::SummariesController < ApplicationController
  before_action :doorkeeper_authorize!, except: %i[ index show ]
  before_action :set_summary, only: %i[ show update destroy ]

  # GET /v1/summaries
  def index
    @summary = Summary.last
    render json: serialize_summary(@summary)
  end

  # GET /v1/summaries/1
  def show
    render json: serialize_summary(@summary)
  end

  # POST /v1/summaries
  def create
    @summary = Summary.new(summary_params)

    if @summary.save
      render json: serialize_summary(@summary), status: :created
    else
      render json: @summary.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/summaries/1
  def update
    if @summary.update(summary_params)
      render json: serialize_summary(@summary)
    else
      render json: @summary.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/summaries/1
  def destroy
    @summary.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_summary
      @summary = Summary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def summary_params
      params.require(:summary).permit(:banner_text, :copy, :header, :banner_image)
    end

    # serialize summary
    def serialize_summary(summary)
      V1::SummarySerializer.new(summary).serializable_hash[:data][:attributes]
    end
end
