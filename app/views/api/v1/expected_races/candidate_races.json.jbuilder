json.set! :candidate_races do
  json.array! @races do |race|
    json.name race.name
    json.track do
      json.id race.track.id
      json.name race.track.name
      json.field_type @field_types["#{race.track.field_type}"]
      json.field_range race.track.field_range
    end
  end
end