import React from 'react';

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

class PokemonForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: "",
      attack: "",
      defense: "",
      poke_type: "",
      moves: "",
      image_url: "",
    };

    this.exampleMethod = this.exampleMethod.bind(this);
  }


  update(property) {
      return e => this.setState({ [property]: e.target.value });
    }

  render () {

    return (
      <form>
        <label>Name:
          <input
            className="input"
            ref="name"
            value={ this.state.name }
            onChange={ this.update('name') }
            />
        </label>
        <label>Attack:
          <input
            className="input"
            ref="attack"
            value={ this.state.attack }
            onChange={ this.update('attack') }
            />
        </label>
        <label>Defense:
          <input
            className="input"
            ref="defense"
            value={ this.state.defense }
            onChange={ this.update('defense') }
            />
        </label>
        <label>Type:
          <input
            className="input"
            ref="poke_type"
            value={ this.state.poke_type }
            onChange={ this.update('poke_type') }
            />
        </label>
        <label>Image:
          <input
            className="input"
            ref="image_url"
            value={ this.state.image_url }
            onChange={ this.update('image_url') }
            />
        </label>


      </form>

    );
  }
}


export default PokemonIndex;
