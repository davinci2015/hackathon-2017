import { combineReducers } from 'redux-immutable';
import reducerEvent from './reducer-events';

// Root reducer combines all other reducers
const rootReducer = combineReducers({
  events: reducerEvent,
});

// Expose root reducer for store
export default rootReducer;
