//import {BootstrapTable, TableHeaderColumn} from 'react-bootstrap-table';


import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'
import thunk from 'redux-thunk';
import TransactionItemApp from '../reducers/index'
import { addTransactionItem, setAuthToken } from '../actions'
import App from './App'



const store = createStore(TransactionItemApp,  applyMiddleware(thunk) );

export default class Transactions extends React.Component {

  constructor(props) {
    super(props);
    store.dispatch(setAuthToken(this.props.authenticity_token));
  };

  render() {
    return (
      <div className="Items col-md-10">
        <Provider store={store}>
          <App />
        </Provider>
      </div>
    )
  }

};
