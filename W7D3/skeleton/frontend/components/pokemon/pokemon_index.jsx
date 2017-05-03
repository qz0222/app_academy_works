import React from 'react';
import PokemonIndexItem from './pokemon_index_item';

class PokemonIndex extends React.Component {
  // constructor (props) {
  //   super(props);
  // }

  componentDidMount () {
    this.props.requestAllPokemon();
  }

  render () {
    if (!this.props) return <div> loading ... </div>;

    const pokemonItems = this.props.pokemons.map(poke => <PokemonIndexItem key={poke.id} pokemon={poke} />);

    return (
      <div className="pokedex">
        <ul>
          {pokemonItems}
        </ul>
        {this.props.children}
      </div>
    );
  }


// And inside the render:

}


export default PokemonIndex;
