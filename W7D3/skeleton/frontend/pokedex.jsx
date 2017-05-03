import React from 'react';
import ReactDOM from 'react-dom';

import * as APIUtil from './util/api_util';
import {receiveAllPokemon, requestAllPokemon} from './actions/pokemon_actions';


import configureStore from './store/store';
import Root from './components/root';
import {selectAllPokemon} from './reducers/selectors';

window.fetchAllPokemon = APIUtil.fetchAllPokemon;

window.receiveAllPokemon = receiveAllPokemon;
window.requestAllPokemon = requestAllPokemon;
window.selectAllPokemon = selectAllPokemon;

document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();
  window.store = store;
  //
  const root = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, root);
});
