class Api::V1::ExpectedRacesController < Api::V1::ApiController
  def create
    ActiveRecord::Base.transaction do
      race = Race.new(create_params.reject{ |k, v| k == 'horse_info' })
      race.race_horses.build(create_params[:horse_info])
      race.save!

      render json: race, status: :ok
    rescue => e
      Rails.logger.error e.message
      render json:{ errors: e.message }, status: :internal_server_error
    end
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

  def create_params
    params.require(:expected_race).permit(
      :event_date,
      :name,
      :track_id,
      :grade,
      horse_info: [
        :horse_id,
        :jockey_id,
        :horse_order
      ]
    ).tap do |v|
      v[:event_date] = v[:event_date].to_date
      v[:is_finish] = 'opening'
    end
  end
end