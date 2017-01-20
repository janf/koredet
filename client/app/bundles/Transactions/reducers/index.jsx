import { combineReducers } from 'redux'
import TransactionItems from './TransactionItems'
import visibilityFilter from './visibilityFilter'

const TransactionItemApp = combineReducers({
  TransactionItems,
  visibilityFilter
})

export default TransactionItemApp