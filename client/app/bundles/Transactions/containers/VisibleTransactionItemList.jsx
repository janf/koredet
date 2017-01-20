import { connect } from 'react-redux'
import { toggleTransactionItem } from '../actions'
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
    }
  }
}

const VisibleTransactionItemList = connect(
  mapStateToProps,
  mapDispatchToProps
)(TransactionItemList)

export default VisibleTransactionItemList