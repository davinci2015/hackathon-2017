import React, {Component} from 'react';
import {fetchTrees} from '../redux/actions/events';
import {connect} from 'react-redux';

const styles = {
  wrapper: {
    margin: '-80px -20px -20px -15px',
  }
};

class MapPage extends Component {

  componentWillMount() {
    let {fetchTrees} = this.props;
    fetchTrees();
  }

  componentDidMount() {
    var position = {lat: 44.772863, lng: 20.475252};
    var mapElem = document.getElementById('map');
    var map = new google.maps.Map(mapElem, {
      zoom: 16,
      center: position
    });

    mapElem.style.width = window.innerWidth + 'px';
    mapElem.style.height = window.innerHeight + 'px';

    var hubConnection = $.hubConnection('http://822a298d.ngrok.io');
    var proxy = hubConnection.createHubProxy('chatHub');
    proxy.on('treePlanted', treePosition => this.generateMarker(treePosition, map));
    hubConnection.start().done(() => console.log('Started listening'));

    setTimeout(() => {
      console.log(this.props.trees);
      this.generateMarkers(this.props.trees, map);
    }, 2000);
  }

  generateMarker(position, map) {
    console.log(position);
    new google.maps.Marker({
      position: position,
      map: map,
      icon: '../images/sprout.png',
      animation: google.maps.Animation.DROP,
    });
  }

  generateMarkers(trees, map) {
    trees.forEach(({lat, lng}) => this.generateMarker({lat, lng}, map));
  }

  render() {
    return (
      <div style={styles.wrapper}>
        <div id="map"></div>
      </div>
    );
  }
}

const mapStateToProps = state => {
  return {
    loading: state.getIn(['events', 'loadingTrees']),
    trees: state.getIn(['events', 'trees']).toJS(),
  }
};

const mapDispatchToProps = dispatch => {
  return {
    fetchTrees: () => dispatch(fetchTrees()),
  }
};

export default connect(mapStateToProps, mapDispatchToProps)(MapPage);
