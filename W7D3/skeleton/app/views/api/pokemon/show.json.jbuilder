json.extract! @pokemon, :id, :name, :attack, :defense

json.image_url asset_path(@pokemon.image_url)

json.extract! @pokemon, :moves, :poke_type

json.items @pokemon.items, :id, :name, :pokemon_id, :price, :happiness, :image_url
