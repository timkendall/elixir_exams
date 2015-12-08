import React from 'react';
import { render } from 'react-dom';
import { Provider } from 'react-redux'
import { Router, Route, Link } from 'react-router';
import configureStore from './store/configureStore';
import SocketService from './services/socket';
import App from './containers/App.jsx';
import './styles.scss';

const store = configureStore();
const TextsChannel = SocketService.configureChannel();

TextsChannel
  .on('new:text', text => store.dispatch({ type: 'ADD_TEXT', text }));

render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.body
)
