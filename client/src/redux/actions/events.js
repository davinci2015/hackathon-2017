
import axios from '../../managers/network/axiosInstance';
import types from '../constants';
import config from '../../config';

let fetchEventsLoading = () => {
  return {
    type: types.FETCH_EVENTS
  }
};

let fetchTreesLoading = () => {
  return {
    type: types.FETCH_TREES
  }
};

let fetchEventsSuccess = events => {
  return {
    type: types.FETCH_EVENTS_SUCCESS,
    payload: {events}
  }
};

let fetchTreesSuccess = trees => {
  return {
    type: types.FETCH_TREES_SUCCESS,
    payload: {trees}
  }
};

let fetchEvents = () => {
  const request = axios.get(`${config.apiUrl}/events`);
  return dispatch => {
    dispatch(fetchEventsLoading());
    return request
      .then(response => {
        let events = response.data;
        dispatch(fetchEventsSuccess(events));
      })
      .catch(error => console.log(error));
  }
};

let fetchTrees = () => {
  const request = axios.get(`${config.apiUrl}/tree`);
  return dispatch => {
    dispatch(fetchTreesLoading());
    return request
      .then(response => {
        let trees = response.data;
        dispatch(fetchTreesSuccess(trees));
      })
      .catch(error => console.log(error));
  }
};

export {
  fetchEvents,
  fetchTrees,
}
