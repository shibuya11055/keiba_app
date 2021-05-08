class Api::V1::HorsesController < Api::V1::ApiController
  def create
    ActiveRecord::Base.transaction do
      horse = Horse.new(create_params)
      horse.save!

      render json: horse, status: :ok
    rescue => e
      Rails.logger.error e.message
      render json:{ errors: e.message }, status: :internal_server_error
    end
  end

  private

  def create_params
    params.require(:horse).permit(
      :name,
      :gender,
      :traner_id
    )
  end
end