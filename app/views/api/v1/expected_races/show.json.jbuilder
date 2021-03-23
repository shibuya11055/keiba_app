json.set! :race_detail do
  json.race do
    json.extract! @race, :name, :grade, :event_date
  end

  json.track do
    json.extract! @race.track, :name, :field_type, :field_range
  end
end
