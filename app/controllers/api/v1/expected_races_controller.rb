class Api::V1::ExpectedRacesController < Api::V1::ApiController
  def new
  end

  def candidate_races
    @races = Race.where("name LIKE ?", "%#{race_name_params[:name]}%").select(:track_id, :name).distinct
    @field_types = Track.field_types_i18n

    render 'api/v1/expected_races/candidate_races', status: :ok
  end

  def candidate_horses
    @horses = Horse.where("name LIKE ?", "%#{candidate_horse_params[:name]}%")
    render 'api/v1/expected_races/candidate_horses', status: :ok
  end

  def candidate_jockeys
    @jockeys = Jockey.where("name LIKE ?", "%#{candidate_jockey_params[:name]}%")
    render 'api/v1/expected_races/candidate_jockeys', status: :ok
  end

  private

  def race_name_params
    params.permit(
      :name
    )
  end

  def candidate_horse_params
    params.permit(
      :name
    )
  end

  def candidate_jockey_params
    params.permit(
      :name
    )
  end
end