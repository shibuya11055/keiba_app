class Api::V1::ExpectedRacesController < Api::V1::ApiController
  def index
    @opening_races = Race.opening.order(:event_date)
  end

  def show
    @race = Race.find(params[:id])

    race_horses = @race.race_horses.order(:horse_order).includes([horse: :traner], :jockey)
    Struct.new(
      'HorseInfo',
      :horse_order,
      :name,
      :point_sum,
      :expected_ranking,
      :jockey_name,
      :traner_name,
      :last_race_name,
      :last_race_grade,
      :last_ranking
    ) unless Struct::const_defined? 'HorseInfo'

    horse_info = race_horses.map do |race_horse|
      horse = race_horse.horse
      name = horse.name

      # 着順予想
      target_races = horse.race_horses.joins(:race).merge(Race.finished)
      # G1(持ちポイント30)
      g_one_race = target_races.merge(Race.g_one)
      g_one_point = g_one_race.pluck(:ranking).select{ |n| n < 4 }.length * 3
      # g_one_point = g_one_race.count * Race::G_ONE_POINT - g_one_race.sum(:ranking)
      # G2(持ちポイント25)
      g_two_race = target_races.merge(Race.g_two)
      g_two_point = g_two_race.pluck(:ranking).select{ |n| n < 4 }.length * 2
      # g_two_point = g_two_race.count * Race::G_TWO_POINT - g_two_race.sum(:ranking)
      # G3(持ちポイント20)
      g_three_race = target_races.merge(Race.g_three)
      g_three_point = g_three_race.pluck(:ranking).select{ |n| n < 4 }.length * 1
      # g_three_point = g_three_race.count * Race::G_THREE_POINT - g_three_race.sum(:ranking)

      point_sum = g_one_point + g_two_point + g_three_point

      expected_ranking = 0
      jockey_name = race_horse.jockey.name
      traner_name = horse.traner.name
      # 前回レースの中間テーブル取得（N+1を起こしているので要修正）
      last_race_horse = RaceHorse.joins(:horse, :race).merge(Horse.where(id: horse.id).merge(Race.finished.order(:event_date))).last
      last_race_name = last_race_horse&.race&.name
      last_race_grade = last_race_horse&.race&.grade
      last_ranking = last_race_horse&.ranking

      Struct::HorseInfo.new(
        race_horse.horse_order,
        name,
        point_sum,
        expected_ranking,
        jockey_name,
        traner_name,
        last_race_name,
        last_race_grade,
        last_ranking
      )
    end
    @horse_info = horse_info.sort_by{|v| v.point_sum}.reverse.each_with_index{|v, i| v.expected_ranking = i + 1}.sort_by{|v| v.horse_order}
    render 'api/v1/expected_races/show', status: :ok
  end

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
    @races = Race.where("name LIKE ?", "%#{race_name_params[:name]}%").select(:track_id, :name).distinct.reverse
    @field_types = Track.field_types_i18n

    # TODO: jbuilderでn+1
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

  def candidate_traners
    @traners = Traner.where("name LIKE ?", "%#{candidate_traner_params[:name]}%")
    render 'api/v1/expected_races/candidate_traners', status: :ok
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

  def candidate_traner_params
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
