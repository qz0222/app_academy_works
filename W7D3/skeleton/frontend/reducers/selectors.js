import React from 'react';
import values from 'lodash/values';

export function selectAllPokemon(state) {
  return values(state.pokemon);
}

export function selectPokemonItem(state, itemId) {
  let itemsArr = state.pokemonDetail.items;

  for (var i = 0; i < itemsArr.length; i++) {
    if (itemsArr[i].id == itemId) {
      return itemsArr[i];
    }
  }
}
