import {connect} from 'react-redux';
// import {selectAllPokemon} from '../../reducers/selectors';
import {createNewPokemon} from '../../actions/pokemon_actions';
import PokemonForm from './pokemon_form';



const mapDispatchToProps = dispatch => ({
  createNewPokemon: (pokemon) => dispatch(createNewPokemon(pokemon))
});


export default connect(
  null,
  mapDispatchToProps
)(PokemonForm);
