let nextTransactionItemId = 0
export const addTransactionItem = (item_name, qty = 1) => {
  return {
    type: 'ADD_TransactionItem',
    id: nextTransactionItemId++,
    item_name,
    qty
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