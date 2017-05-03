import {connect} from 'react-redux';
// import {selectOnePokemon} from '../../reducers/selectors';
import {requestOnePokemon} from '../../actions/pokemon_actions';
import PokemonDetail from './pokemon_detail';

const mapStateToProps = state => {
  //That is why we create the selector
  return ({pokemon: state.pokemonDetail});
};

const mapDispatchToProps = dispatch => ({
  requestOnePokemon: (pokeId) => dispatch(requestOnePokemon(pokeId))
});


export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonDetail);
