class Api::V1::ExpectedRacesController < Api::V1::ApiController
  def new
  end

  def candidate_races
    @races = Race.where("name LIKE ?", "%#{race_name_params[:name]}%").select(:track_id, :name).distinct
    @field_types = Track.field_types_i18n

    render 'api/v1/expected_races/candidate_races', status: :ok
  end

  private

  def race_name_params
    params.permit(
      :name
    )
  end
end