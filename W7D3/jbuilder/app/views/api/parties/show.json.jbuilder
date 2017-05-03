json.extract! @party, :name

json.guests do
  json.array! @party.guests do |guest|
    json.extract! guest, :name
    json.gifts guest.gifts, :title, :description
  end
end
