json.set! :candidate_horses do
  json.array! @horses do |horse|
    json.id horse.id
    json.name horse.name
  end
end