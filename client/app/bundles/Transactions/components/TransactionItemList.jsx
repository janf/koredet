import React, { PropTypes } from 'react'
import TransactionItem from './TransactionItem'
import { BootstrapTable, TableHeaderColumn } from 'react-bootstrap-table';



const options = {

        defaultSortName: 'id',
        defaultSortOrder: 'desc',

        clearSearch: true,

        page: 1,  // which page you want to show as default
        sizePerPageList: [ {
          text: '10', value: 10
        },{
          text: '15', value: 15
        },{
          text: '20', value: 20
        } ], // you can change the dropdown list for size per page
        sizePerPage: 15,  // which size per page you want to locate as default
        pageStartIndex: 1, // where to start counting the pages
        paginationSize: 5,  // the pagination bar size.
        prePage: 'Prev', // Previous page button text
        nextPage: 'Next', // Next page button text
        firstPage: 'First', // First page button text
        lastPage: 'Last', // Last page button text
        // hideSizePerPage: true > You can hide the dropdown for sizePerPage

        //afterInsertRow: this.handleInsertedRow,
        //afterDeleteRow: this.handleDeleteRow,
        // afterDeleteRow: this.handleDeletedRow
      };


      const cellEditProp = {
        mode: 'dbclick',
        blurToSave: true
      };

      const selectRowProp = {
        mode: 'checkbox',
        showOnlySelected: true
      };

const TransactionItemList = ({ TransactionItems, onTransactionItemClick, onTransactionInsert, onTransactionUpdate, onTransactionDelete }) => (
  <BootstrapTable data={TransactionItems} 
                    exportCSV striped cellEdit={{ ...cellEditProp, afterSaveCell: onTransactionUpdate }} hover condensed 
                    search  deleteRow selectRow={ selectRowProp } 
                    pagination options={{ ...options, afterDeleteRow: onTransactionDelete   }}>
               <TableHeaderColumn dataField="id" isKey  autoValue dataAlign="center" hidden width="50" dataSort editable={false}>Trans Id</TableHeaderColumn>
               <TableHeaderColumn dataField="item_name" width="100">Item Name</TableHeaderColumn>
                <TableHeaderColumn dataField="qty" width="100">Qty</TableHeaderColumn>
               <TableHeaderColumn dataField="created_at" width="80" dataSort editable={false} >Created at</TableHeaderColumn>
  </BootstrapTable>
)

TransactionItemList.propTypes= {
  TransactionItems: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number.isRequired,
    item_name: PropTypes.string.isRequired
  }).isRequired).isRequired,
  onTransactionItemClick: PropTypes.func.isRequired
}

export default TransactionItemList


  // <ul>
  //   {TransactionItems.map(ti =>
  //     <TransactionItem
  //       key={ti.id}
  //       {...ti}
  //       onClick={() => onTransactionItemClick(ti.id)}
  //     />
  //   )}
  // </ul>
