class Api::V1::RacesController < Api::V1::ApiController
  def destroy
    ActiveRecord::Base.transaction do
      race = Race.find(params[:id])
      race.finished!

      render json: race, status: :ok
    rescue => e
      Rails.logger.error e.message
      render json:{ errors: e.message }, status: :internal_server_error
    end
  end
end