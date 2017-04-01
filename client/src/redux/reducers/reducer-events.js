import types from '../constants';
import {Map, List, fromJS} from 'immutable';

const initialState = Map({
  data: List(),
  trees: List(),
  loading: false,
  loadingTrees: false,
});

export default function reducerEvent(state = initialState, action) {
  switch (action.type) {
    case types.FETCH_EVENTS:
      state = state.set('loading', true);
      return state;
    case types.FETCH_EVENTS_SUCCESS:
      state = state.set('loading', false);
      state = state.set('data', fromJS(action.payload.events));
      return state;
    case types.FETCH_TREES:
      state = state.set('loading', true);
      return state;
    case types.FETCH_TREES_SUCCESS:
      state = state.set('trees', fromJS(action.payload.trees));
      state = state.set('loadingTrees', false);
      return state;
    default:
      return state;
  }
}
