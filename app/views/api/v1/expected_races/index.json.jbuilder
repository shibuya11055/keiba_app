json.set! :expected_races do
  json.array! @opening_races do |race|
    json.id race.id
    json.event_date race.event_date
    json.grade race.grade
    json.name race.name
  end
end