import React from 'react'
import { connect } from 'react-redux'
import { addTransactionItem, addTransactionItemAsync } from '../actions'


let AddTransactionItem = ({ dispatch }) => {
  let item_name, qty


  return (
    <div>
      <form onSubmit={e => {
        e.preventDefault()
        if (!item_name.value.trim()) {
          return
        }
        if(qty.value.length == 0) {
            qty.value = 1;
        }
        dispatch(addTransactionItemAsync(item_name.value, qty.value))
        item_name.value = ''
        qty.value = ''
      }}>
        <input placeholder="Item name"
              ref={node => {
          item_name = node
        }} />

        <input  placeholder="Qty"
        ref={node => {
          qty = node
        }} />



        <button type="submit">
          Add TransactionItem
        </button>
      </form>
    </div>
  )
}
AddTransactionItem = connect()(AddTransactionItem)

export default AddTransactionItem