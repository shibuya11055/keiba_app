json.set! :candidate_traners do
  json.array! @traners do |traner|
    json.id traner.id
    json.name traner.name
  end
end