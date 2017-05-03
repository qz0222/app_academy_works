import {connect} from 'react-redux';
import {selectPokemonItem} from '../../../reducers/selectors';
// import {requestOnePokemon} from '../../actions/pokemon_actions';
import ItemDetail from './item_detail';

const mapStateToProps = (state, ownProps) => {
  //That is why we create the selector
  return ({item: selectPokemonItem(state, ownProps.params.itemId)});

};

export default connect(
  mapStateToProps
)(ItemDetail);
