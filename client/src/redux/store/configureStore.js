import { createStore, compose, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { createLogger } from 'redux-logger';
import { fromJS } from 'immutable';
import reducer from '../reducers';
import { loadStateFromStorage } from '../../managers/storage/localStorage';

export default function configureStore(initialState = {}) {
  const logger = createLogger();

  // TODO remove logger middleware when we're in production
  const enhancer = compose(applyMiddleware(thunk, logger));

  // Load initial state from storage
  initialState = fromJS(loadStateFromStorage());

  // Return created store with all
  // reducers, initial state and middlewares/enhancers
  return createStore(
    reducer,
    initialState,
    enhancer
  );
}
