json.set! :candidate_jockeys do
  json.array! @jockeys do |jockey|
    json.id jockey.id
    json.name jockey.name
  end
end