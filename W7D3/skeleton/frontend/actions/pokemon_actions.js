export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_ONE_POKEMON = "RECEIVE_ONE_POKEMON";
export const RECEIVE_NEW_POKEMON = "RECEIVE_NEW_POKEMON";


import * as APIUtil from '../util/api_util';

export const receiveAllPokemon = pokemons => ({
  type: RECEIVE_ALL_POKEMON,
  pokemons
});

export const receiveOnePokemon = pokemon => ({
  type: RECEIVE_ONE_POKEMON,
  pokemon
});

export const receiveNewPokemon = pokemon => ({
  type: RECEIVE_NEW_POKEMON,
  pokemon
});



export const requestAllPokemon = () => (dispatch) => {
  return APIUtil.fetchAllPokemon()
    .then(pokemons => dispatch(receiveAllPokemon(pokemons)));
};

export const requestOnePokemon = (pokeId) => (dispatch) => {
  return APIUtil.fetchOnePokemon(pokeId)
    .then(pokemon => dispatch(receiveOnePokemon(pokemon)));
};

export const createNewPokemon = (pokemon) => (dispatch) => {
  return APIUtil.createPokemon(pokemon)
    .then(pokemon => dispatch(receiveNewPokemon(pokemon)));
};
