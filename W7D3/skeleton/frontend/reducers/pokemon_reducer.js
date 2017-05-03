import { RECEIVE_ALL_POKEMON } from '../actions/pokemon_actions';
import merge from 'lodash/merge';


const pokemonReducer = (state = {}, action) => {
  switch(action.type){
    case RECEIVE_ALL_POKEMON:
      return action.pokemons;
    case RECEIVE_NEW_POKEMON:
      return merge({}, state, action.pokemon);
    default:
      return state;
  }

};

export default pokemonReducer;
