import React from 'react';
import ReactDOM from 'react-dom';
import Root from './root';


document.addEventListener('DOMContentLoaded', () => {
  const main = document.getElementById('content');
  ReactDOM.render(<Root />, main);
});
