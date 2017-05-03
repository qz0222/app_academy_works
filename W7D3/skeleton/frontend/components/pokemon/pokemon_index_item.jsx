import React from 'react';
import { Link } from 'react-router';


const PokemonIndexItem = (props) => {
  return (
    <li className='pokemon-list-item' >
      <Link to={`/pokemon/${props.pokemon.id}`}>
        {props.pokemon.name}
        <img src={props.pokemon.image_url} />
      </Link>
    </li>
  );
};

export default PokemonIndexItem;
