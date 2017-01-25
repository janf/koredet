import { post, update, delete_ } from '../../../lib/railsclient'

let nextTransactionItemId = 0
export const addTransactionItem = (id, item_name, qty, created_at) => {
  return {
    type: 'ADD_TransactionItem',
    id,
    item_name,
    qty, 
    created_at
  }
}


export const updateTransactionItem = (row) => {
  return {
    type: 'UPDATE_TransactionItem',
    row
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


export function testAction (item_name, qty) {
  
  return function (dispatch, getState) {
      var item_type_id = 1
      var qty = qty || 1
      const payload = {transaction: {item_name, item_type_id, qty}};
      console.log("Payload in testAction: " + JSON.stringify(payload));
      console.log("CSRF: " + JSON.stringify(getState().authToken) );
      
      return post("/apiv1/transactions", payload, getState().authToken).then(ret => {
           console.log("Return values in testAction: " + JSON.stringify(ret));
           dispatch(addTransactionItem(ret.id, ret.item_name, ret.qty, ret.created_at))
         }
        ) 
    }   
}



export function addTransactionToDB  (item_name, qty) {
    return {
      type: 'ADD_TransactionItem',
      id: 88,
      item_name,
      qty
    }   
}
