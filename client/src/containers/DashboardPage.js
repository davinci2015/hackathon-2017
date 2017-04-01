import React, {Component} from 'react';
import {connect} from 'react-redux';
import {cyan600, pink600, purple600, orange600} from 'material-ui/styles/colors';
import Assessment from 'material-ui/svg-icons/action/assessment';
import Face from 'material-ui/svg-icons/action/face';
import ThumbUp from 'material-ui/svg-icons/action/thumb-up';
import ShoppingCart from 'material-ui/svg-icons/action/shopping-cart';
import InfoBox from '../components/dashboard/InfoBox';
import {Card, CardActions, CardMedia, CardTitle, CardText} from 'material-ui/Card';
import globalStyles from '../styles';
import FlatButton from 'material-ui/FlatButton';
import {fetchEvents} from '../redux/actions/events';
import {toJS} from 'immutable';
import moment from 'moment';

class DashboardPage extends Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    let {fetchEvents} = this.props;
    fetchEvents();
  }

  renderEvents(events) {
    return events.map(event => {
      let date = moment(event.startDate).format('DD.MM.YYYY');
      return (
        <div className="col-md-4" key={event.id}>
          <Card>
            <CardMedia
              overlay={<CardTitle title={event.name} subtitle={date}/>}
            >
              <img src={event.image}/>
            </CardMedia>
            <CardTitle title={event.name} subtitle={`Broj polaznika: ${event.count}`}/>
            <CardText>
              {event.description}
            </CardText>
            <CardActions>
              <FlatButton label="Uredi"/>
              <FlatButton label="Obriši"/>
            </CardActions>
          </Card>
        </div>
      );
    });
  }

  render() {
    let {events, loading} = this.props;
    if (loading) return (<div></div>);
    return (
      <div>
        <h3 style={globalStyles.navigation}>Application / Dashboard</h3>

        <div className="row">

          <div className="col-xs-12 col-sm-6 col-md-3 col-lg-3 m-b-15 ">
            <InfoBox Icon={ShoppingCart}
                     color={pink600}
                     title="Total Profit"
                     value="1500k"
            />
          </div>


          <div className="col-xs-12 col-sm-6 col-md-3 col-lg-3 m-b-15 ">
            <InfoBox Icon={ThumbUp}
                     color={cyan600}
                     title="Likes"
                     value="4231"
            />
          </div>

          <div className="col-xs-12 col-sm-6 col-md-3 col-lg-3 m-b-15 ">
            <InfoBox Icon={Assessment}
                     color={purple600}
                     title="Sales"
                     value="460"
            />
          </div>

          <div className="col-xs-12 col-sm-6 col-md-3 col-lg-3 m-b-15 ">
            <InfoBox Icon={Face}
                     color={orange600}
                     title="New Members"
                     value="248"
            />
          </div>
        </div>


        <div className="row">
          {this.renderEvents(events)}
        </div>

      </div>
    );
  }
}

const mapStateToProps = state => {
  return {
    loading: state.getIn(['events', 'loading']),
    events: state.getIn(['events', 'data']).toJS(),
  }
};

const mapDispatchToProps = dispatch => {
  return {
    fetchEvents: () => dispatch(fetchEvents()),
  }
};

export default connect(mapStateToProps, mapDispatchToProps)(DashboardPage);
