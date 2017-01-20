import React from 'react'
import Footer from './Footer'
import AddTransactionItem from '../containers/AddTransactionItem'
import VisibleTransactionItemList from '../containers/VisibleTransactionItemList'
import Dictaphone from './Dictaphone'


const App = () => (
  <div>
  	<h2>Legg inn/ta ut/flytt</h2>
  	<h3>Fra - Til</h3>
  	<Dictaphone />
    <AddTransactionItem />
    <VisibleTransactionItemList />
    <Footer />
  </div>
)

export default App