//import {BootstrapTable, TableHeaderColumn} from 'react-bootstrap-table';

import React from 'react';
import Item  from './Item';
import { BootstrapTable, TableHeaderColumn } from 'react-bootstrap-table';
import Select from 'react-select';
import moment from 'moment';


export default class Items extends React.Component {

	constructor(props) {
		super(props);
    this.state = {editmode: "hidden", recordkey: "", data: props.data};
    this.handleAddRecord = this.handleAddRecord.bind(this);
    this.itemTypeFormatter = this.itemTypeFormatter.bind(this);
    //this.handleEditEvent = this.handleEditEvent.bind(this);
	};

  handleAddRecord(e) {
     this.setState({editmode: "new"});
  }

  // handleEditEvent(app_event, payload) {
  //   if(app_event == "exit") {
  //     this.setState({editmode: "hidden", recordkey: ""})   
  //   } else if(app_event == "add") {
  //       console.log("Will save data: " + JSON.stringify(payload, null, "\t") );
  //        $.ajax({
  //          data: payload,
  //          url: "/records",
  //          type: "POST",
  //          dataType: "json",
  //          success: data => {
  //            this.setState({data: this.state.data.concat(data) });
  //          }})
  //   } else if(app_event == "delete") {
  //     console.log("Will delete data: " + JSON.stringify(payload, null, "\t") );
  //     $.ajax({
  //          data: payload,
  //          url: "/records/"+ payload.id,
  //          type: "DELETE",
  //          dataType: "json",
  //          success: data => {
  //           console.log("Delete succedeed");
  //           const deleted_id = parseInt(payload.id,10);
  //           this.setState({data: this.state.data.filter(({ id }) => id !== deleted_id)});
  //          }})

  //   } else if(app_event == "edit"){
  //     console.log("Start edit data: " + JSON.stringify(payload, null, "\t") );
  //     this.setState({editmode: "edit", recordkey: payload.id})
  //     //console.log("handleEditEvent: " + app_event);
  //   } else if(app_event == "save") {
  //       console.log("Saving data: " + JSON.stringify(payload, null, "\t") );
  //       this.setState({editmode: "hiddden", recordkey: ""});
  //   }


  // }
  
  dateFormatter(cell, row){
      //return cell;
      return moment(cell).format("YYYY-MM-DD");
  }

  itemTypeFormatter(cell, row){
      //return cell;
      const id = parseInt(cell);
      return this.props.item_types.filter(it => it.id === id)[0].name;
  }

 
	render() {

      let editpane;

      if(this.state.editmode == "hidden") {
        editpane =  <button  id="add" className="btn-xs btn-primary" onClick={this.handleAddRecord}>Add Record</button>;
      } else {
        editpane =  <button  id="save" className="btn-xs btn-primary" onClick={this.handleAddRecord}>Save Record</button>;
        //editpane =  <Item onEditEvent={this.handleEditEvent} authenticity_token={this.props.authenticity_token} />;
      };

      const cellEditProp = {
        mode: 'dbclick',
        blurToSave: true
      };

      const selectRowProp = {
        mode: 'checkbox'
      };

      const itemType = this.props.item_types.reduce((obj, {id, name}) => (obj[id] = name, obj), {});

      function enumFormatter(cell, row, enumObject) {
        return enumObject[cell];
      }

      const options = {
        page: 1,  // which page you want to show as default
        sizePerPageList: [ {
          text: '10', value: 10
        }, {
          text: '20', value: 20
        }, {
          text: 'All', value: this.state.data.length
        } ], // you can change the dropdown list for size per page
        sizePerPage: 20,  // which size per page you want to locate as default
        pageStartIndex: 1, // where to start counting the pages
        paginationSize: 5,  // the pagination bar size.
        prePage: 'Prev', // Previous page button text
        nextPage: 'Next', // Next page button text
        firstPage: 'First', // First page button text
        lastPage: 'Last', // Last page button text
        paginationShowsTotal: this.renderShowsTotal  // Accept bool or function
        // hideSizePerPage: true > You can hide the dropdown for sizePerPage
      };

      var select_options = [
        { value: 'one', label: 'One' },
        { value: 'two', label: 'Two' }
      ];

      function logChange(val) {
        console.log("Selected: " + val);
      }
   


    	return (
    	 		<div className="Items col-md-8">
            <h2>Items</h2>
            <Select
              name="item-type-select"
              width="50"
              value="one"
              options={  this.props.item_types }
              onChange={logChange}
            />
         
       	    <BootstrapTable data={this.state.data} 
                    exportCSV striped cellEdit={ cellEditProp } hover condensed 
                    search insertRow deleteRow selectRow={ selectRowProp } 
                    pagination options={ options }>
               <TableHeaderColumn dataField="id" isKey dataAlign="center" width="50" dataSort editable={false}>Item Id</TableHeaderColumn>
               <TableHeaderColumn dataField="item_type_id" width="150" dataSort  dataFormat={ this.itemTypeFormatter } 
                                  filterFormatted dataFormat={ enumFormatter } editable={ { type: 'select', options: { values: this.props.item_types.map(it => it.id) } } }
                formatExtraData={ itemType } filter={ { type: 'SelectFilter', options: itemType }  }>
               Item Type</TableHeaderColumn>
               <TableHeaderColumn dataField="name" width="150" dataSort >Item Name</TableHeaderColumn>
               <TableHeaderColumn dataField="description" width="150">Item Description</TableHeaderColumn>
               <TableHeaderColumn dataField="created_at" width="150" dataFormat={ this.dateFormatter } dataSort editable={false} >Create date</TableHeaderColumn>
             </BootstrapTable>
          </div>
  	   );
  	};
}
