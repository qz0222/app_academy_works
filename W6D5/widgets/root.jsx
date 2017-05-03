import React from 'react';
import Clock from './frontend/clock';
import Weather from './frontend/weather';

class Root extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {

    return (
      <div>
        <Clock/>
        <Weather/>
      </div>
    );
  }
}

export default Root;
