import { post, update, delete_ } from '../../../lib/railsclient'

let nextTransactionItemId = 0
export const addTransactionItem = (row) => {
  return {
    type: 'ADD_TransactionItem',
    id: row.id,
    item_name: row.item_name,
    qty: row.qty,
    created_at: row.created_at
  }
}


export const updateTransactionItem = (row) => {
  return {
    type: 'UPDATE_TransactionItem',
    id: row.id,
    item_name: row.item_name,
    qty: row.qty,
    created_at: row.created_at
  }
}




export const deleteTransactionItems = (ids) => {
  return {
    type: 'DELETE_TransactionItems',
    ids
  }
}


export const setVisibilityFilter = (filter) => {
  return {
    type: 'SET_VISIBILITY_FILTER',
    filter
  }
}

export const toggleTransactionItem = (id) => {
  return {
    type: 'TOGGLE_TransactionItem',
    id
  }
}

export const setAuthToken = (auth_token) => {
  //console.log("setAuthToken");
  return {
    type: 'SET_AUTH_TOKEN',
    auth_token
  }
}


export function addTransactionItemAsync (item_name, qty) {
  return function (dispatch, getState) {
      var item_type_id = 1
      if(!qty) {
        qty =1
      };
      const payload = {transaction: {item_name, item_type_id, qty}};
      console.log("Payload in addTransactionItemAsync: " + JSON.stringify(payload));
      console.log("CSRF: " + JSON.stringify(getState().authToken) );
      
      return post("/apiv1/transactions", payload, getState().authToken).then(ret => {
           console.log("Return values in addTransactionItemAsync: " + JSON.stringify(ret));
           dispatch(addTransactionItem(ret))
         }
        ) 
    }   
}

export function updateTransactionItemAsync (row, cellName, cellValue) {
    console.log("Cellname: " + cellName + ", Cellvalue: " + cellValue);
    return function (dispatch, getState) {

      var id = row.id
      
      var  transaction = {};
      transaction["id"] = id;
      transaction[cellName] = cellValue;

      var payload = {transaction: transaction};
      console.log("Payload in updateTransactionItemAsync: " + JSON.stringify(payload));
      console.log("CSRF: " + JSON.stringify(getState().authToken) );
      
      return update("/apiv1/transactions/", id, payload, getState().authToken).then(ret => {
           console.log("Return values in updateTransactionItemAsync: " + JSON.stringify(ret));
           dispatch(updateTransactionItem(ret))
         }
        ) 
    }   
}


