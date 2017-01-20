const TransactionItem = (state = {}, action) => {
  switch (action.type) {
    case 'ADD_TransactionItem':
      return {
        id: action.id,
        item_name: action.item_name,
        qty: action.qty,
        completed: false
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
    case 'TOGGLE_TransactionItem':
      return state.map(t =>
        TransactionItem(t, action)
      )
    default:
      return state
  }
}

export default TransactionItems