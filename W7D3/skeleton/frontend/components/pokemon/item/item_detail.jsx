import React from 'react';

const ItemDetail = (props) => {
  if (Object.keys(props.item).length === 0) return (<div>loading...</div>);
  return (

    <ul className='item-detail'>
      <li>{props.item.name}</li>
      <li>Happiness: {props.item.happiness}</li>
      <li>Price: {props.item.price}</li>
    </ul>
  );
};

export default ItemDetail;
