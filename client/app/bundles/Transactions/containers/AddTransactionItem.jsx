import React from 'react'
import { connect } from 'react-redux'
import { addTransactionItem } from '../actions'


let AddTransactionItem = ({ dispatch }) => {
  let input

  return (
    <div>
      <form onSubmit={e => {
        e.preventDefault()
        if (!input.value.trim()) {
          return
        }
        dispatch(addTransactionItem(input.value))
        input.value = ''
      }}>
        <input ref={node => {
          input = node
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