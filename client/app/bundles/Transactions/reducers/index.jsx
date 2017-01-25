import { combineReducers } from 'redux'
import TransactionItems from './TransactionItems'
import visibilityFilter from './visibilityFilter'
import authToken from './authToken'


const TransactionItemApp = combineReducers({
  TransactionItems,
  visibilityFilter,
  authToken,
})

export default TransactionItemApp