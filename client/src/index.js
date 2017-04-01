import React from 'react';
import { render } from 'react-dom';
import { Router, browserHistory } from 'react-router';
import { Provider } from 'react-redux';
import configureStore from './redux/store/configureStore';
import routes from './routes';
import injectTapEventPlugin from 'react-tap-event-plugin';
import { saveStateToStorage } from './managers/storage/localStorage';
require('./favicon.ico');
import './styles.scss';
import 'font-awesome/css/font-awesome.css';
import 'flexboxgrid/css/flexboxgrid.css';

injectTapEventPlugin();

// Create store
const store = configureStore();
store.subscribe(() => {
  saveStateToStorage();
});

render(
  <Provider store={store}>
      <Router routes={routes} history={browserHistory} />
  </Provider>,
  document.getElementById('app')
);
