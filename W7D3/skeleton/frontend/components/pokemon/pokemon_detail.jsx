import React from 'react';
import forEach from 'lodash/forEach';
import { Link } from 'react-router';

class PokemonDetail extends React.Component {
  // constructor (props) {
  //   super(props);
  // }

  componentDidMount () {
    this.props.requestOnePokemon(this.props.params.pokeId);
  }

  componentWillReceiveProps (newProps) {
    if (newProps.params.pokeId != this.props.params.pokeId) {
      this.props.requestOnePokemon(newProps.params.pokeId);
    }
  }


  render () {
    // let details = [];

    // if (this.props.pokemon.name) {
    //   debugger
    //   forEach((this.props.pokemon), (value, key) => (details.push(<li>{key}: {value}</li>)));
    //   debugger
    // }
    let thisPoke = this.props.pokemon;

    let items;
    if (this.props.pokemon.items) {
      items = this.props.pokemon.items.map( (item, idx) => {return (
        <li key={idx}>
          <Link to={`/pokemon/${this.props.pokemon.id}/item/${item.id}`}>
            {item.name}
            <img src={item.image_url}/>
          </Link>
        </li>
      );} );
    }

    if (Object.keys(this.props.pokemon).length === 0) return (<div>loading...</div>);
    return (
      <div className="pokemon-details">
        <ul>
          <li>{thisPoke.name}</li>
          <li>Type: {thisPoke.poke_type}</li>
          <li>Attack: {thisPoke.attack}</li>
          <li>Defense: {thisPoke.defense}</li>
          <li>Moves: {thisPoke.moves}</li>
          {items}
        </ul>
        {this.props.children}
      </div>
    );
  }


  // <li>Items {thisPoke.items}</li>
// And inside the render:

}


export default PokemonDetail;
