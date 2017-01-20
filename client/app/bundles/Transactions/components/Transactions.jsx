//import {BootstrapTable, TableHeaderColumn} from 'react-bootstrap-table';


import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import TransactionItemApp from '../reducers/index'
import App from './App'


const store = createStore(TransactionItemApp);

export default class Transactions extends React.Component {

  constructor(props) {
    super(props);
   
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
