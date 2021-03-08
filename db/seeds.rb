today = Date.today

jockey1 = Jockey.create!(
  name: 'ジョッキー１',
  birthday: today,
  registration_number: 0
)

jockey2 = Jockey.create!(
  name: 'ジョッキー２',
  birthday: today,
  registration_number: 1
)

traner1 = Traner.create!(
  name: 'トレーナー１',
  birthday: today,
  registration_number: 0
)

traner2 = Traner.create!(
  name: 'トレーナー１',
  birthday: today,
  registration_number: 1
)

hourse1 = Horse.create!(
  name: 'テスト馬',
  gender: 0,
  birthday: today,
  traner_id: traner1.id
)

hourse2 = Horse.create!(
  name: 'テスト馬2',
  gender: 1,
  birthday: today,
  traner_id: traner2.id
)

track = Track.create!(
  name: 'テスト競馬場',
  field_type: 0,
  field_range: 1600
)

race = Race.create!(
  name: 'テスト賞',
  event_date: today,
  track_id: track.id,
  grade: 0,
  is_finish: 1
)

RaceHorse.create!([
  {
    horse_id: hourse1.id,
    race_id: race.id,
    jockey_id: jockey1.id,
    ranking: 1,
    post_position: 1
  },
  {
    horse_id: hourse2.id,
    race_id: race.id,
    jockey_id: jockey2.id,
    ranking: 2,
    post_position: 2
  }
])
