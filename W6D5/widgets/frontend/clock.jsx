import React from 'react';

const days = [];

class Clock extends React.Component {
  constructor (props) {
    super(props);
    this.state = { time: new Date()};
    this.tick = this.tick.bind(this);
  }

  componentDidMount() {
    this.interval = setInterval(this.tick, 1000);
  }

  componentWillUnmount(){
    clearInterval(this.interval);
  }

  tick() {
    this.setState({time: new Date()});
  }

  render() {
    return (
      <div className='clock'>
        <ul>
          <li>
            <span>Time:</span>
            <span>{this.state.time.toLocaleTimeString()}</span>
          </li>
          <li>
            <span>Date:</span>
            <span>{this.state.time.toLocaleDateString()}</span>
          </li>
        </ul>
      </div>
    );
  }
}

export default Clock;
