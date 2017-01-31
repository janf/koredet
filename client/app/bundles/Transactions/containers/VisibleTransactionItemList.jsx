import { connect } from 'react-redux'
import { toggleTransactionItem, updateTransactionItemAsync, deleteTransactionItems } from '../actions'
import TransactionItemList from '../components/TransactionItemList'

const getVisibleTransactionItems = (TransactionItems, filter) => {
  switch (filter) {
    case 'SHOW_ALL':
      return TransactionItems
    case 'SHOW_COMPLETED':
      return TransactionItems.filter(t => t.completed)
    case 'SHOW_ACTIVE':
      return TransactionItems.filter(t => !t.completed)
  }
}

const mapStateToProps = (state) => {
  return {
    TransactionItems: getVisibleTransactionItems(state.TransactionItems, state.visibilityFilter)
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    onTransactionItemClick: (id) => {
      dispatch(toggleTransactionItem(id))
    },
    onTransactionInsert: (row) => {
      dispatch(addTransactionItem(row.item_name, row.qty))
    },
    onTransactionDelete: (ids) => {
      dispatch(deleteTransactionItems(ids))
    },
    onTransactionUpdate: (row,cellName, cellValue) => {
      dispatch(updateTransactionItemAsync(row, cellName, cellValue))
    }
  }
}

const VisibleTransactionItemList = connect(
  mapStateToProps,
  mapDispatchToProps
)(TransactionItemList)

export default VisibleTransactionItemList