import React from 'react';

class Weather extends React.Component{
  constructor(props){
    super(props);
    // this.latitude = 0;
    // this.longitude = 0;

    this.state = {
      lat: "",
      lng: ""
    };
  }

  componentDidMount() {
    this.getLocation();
    // debugger
  }

  getLocation() {
    let success = (pos) => {
      let crd = pos.coords;

      this.setState({
        lat: crd.latitude,
        lng: crd.longitude,
      }, this.request.bind(this));

    };
    navigator.geolocation.getCurrentPosition(success.bind(this));
    // debugger
  }

  request() {
    let request = new XMLHttpRequest();
    request.open('GET', `http://api.openweathermap.org/data/2.5/weather?lat=${this.state.lat}&lon=${this.state.lng}&APPID=124709348aa38808a15437f47457ae17`, true);

    request.onload = function() {
      if (request.status >= 200 && request.status < 400) {
        // Success!
        var resp = request.responseText;
        // console.log(resp);
        debugger
      } else {
        alert("unable to get weather");
        // We reached our target server, but it returned an error
      }
    };

    request.onerror = function() {
      // There was a connection error of some sort
    };

    request.send();
  }

  render() {
    return(
      <div>
        <span>{this.state.lat}</span>
      </div>
    );
  }


}

export default Weather;


// &APPID=124709348aa38808a15437f47457ae17
