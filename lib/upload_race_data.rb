class UploadRaceData
  require 'csv'

  def exec
    CSV.foreach('/Users/shibuya.kyohei/work/test_app/keiba_app/lib/result.csv', headers: true) do |row|
      if standard_race?(row['グレード'])
        ActiveRecord::Base.transaction do
          jockey = Jockey.find_or_create_by(name: row['騎手'])
          traner = Traner.find_or_create_by(name: row['調教師'])
          horse = Horse.find_or_create_by(name: row['馬名'], gender: gender(row['性別']), traner: traner)
          track = Track.find_or_create_by(name: row['競馬場'], field_type: field_type(row['種別']), field_range: row['距離'].to_i)

          event_date = row['日時'].to_date
          race = Race.find_or_create_by(
            name: row['レース名'],
            event_date: event_date,
            track: track,
            grade: grade(row['グレード']),
            is_finish: 'finished'
          )

          RaceHorse.find_or_create_by(
            horse: horse,
            race: race,
            jockey: jockey,
            ranking: row['着順'].to_i,
            post_position: row['枠'].to_i,
            horse_order: row['馬番'].to_i
          )
        rescue => e
          p e.message
        end
      end
    end
  end

  def grade(val)
    if val == 'GⅠ'
      'g_one'
    elsif val == 'GⅡ'
      'g_two'
    elsif val == 'GⅢ'
      'g_three'
    end
  end

  def gender(val)
    gender = val == '牡' ? 'male' : 'female'
    gender
  end

  def field_type(val)
    type = val == '芝' ? 'turf' : 'dirt'
    type
  end

  def standard_race?(grade)
    grade == 'GⅠ' || grade == 'GⅡ' || grade == 'GⅢ'
  end
end

# CSV_HEADER = ['日時', '競馬場', 'レース名', 'グレード', '距離', '種別', '着順', '枠', '馬番', '馬名', '性別', '騎手', '調教師']
