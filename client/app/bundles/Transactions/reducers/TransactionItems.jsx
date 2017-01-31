const TransactionItem = (state = {}, action) => {

  switch (action.type) {
    case 'ADD_TransactionItem':
      console.log("ADD_TransactionItem: " + JSON.stringify(action));
      return {
        id: action.id,
        item_name: action.item_name,
        qty: action.qty,
        created_at: action.created_at
      }

    case 'TOGGLE_TransactionItem':
      if (state.id !== action.id) {
        return state
      }

      return Object.assign({}, state, {
        completed: !state.completed
      })

    default:
      return state
  }
}

const TransactionItems = (state = [], action) => {
  switch (action.type) {
    case 'ADD_TransactionItem':
      return [
        ...state,
        TransactionItem(undefined, action)
      ]
    case 'UPDATE_TransactionItem':
      return state.map(row => row.id === action.id ? {...row, ...action} : row);
    

    case 'DELETE_TransactionItems':
      return state.filter(({ id }) => !action.ids.includes(id));
      
    case 'TOGGLE_TransactionItem':
      return state.map(t =>
        TransactionItem(t, action)
      )
    default:
      return state
  }
}

export default TransactionItems;