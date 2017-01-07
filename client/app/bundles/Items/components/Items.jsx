//import {BootstrapTable, TableHeaderColumn} from 'react-bootstrap-table';

import React from 'react';
import Item  from './Item';
import { BootstrapTable, TableHeaderColumn } from 'react-bootstrap-table';
import Select from 'react-select';
import moment from 'moment';
import { post, update, delete_ } from '../../../lib/railsclient';
import ImageEditor from './ImageEditor'

export default class Items extends React.Component {

	constructor(props) {
		super(props);
    this.state = {editmode: "hidden", recordkey: "", data: props.data, select_value: []};
    this.handleAddRecord = this.handleAddRecord.bind(this);
    this.itemTypeFormatter = this.itemTypeFormatter.bind(this);
    this.handleInsertedRow = this.handleInsertedRow.bind(this);
    this.handleEditCell = this.handleEditCell.bind(this);
    this.handleDeleteRow = this.handleDeleteRow.bind(this);
    //this.handleEditEvent = this.handleEditEvent.bind(this);
	};

  handleAddRecord(e) {
     this.setState({editmode: "new"});
  }

  handleInsertedRow(row) {
     console.log("Inserting ", row );
     const payload = {item: {...row}, authenticity_token: this.props.authenticity_token};
     delete payload.item.id;
     console.log("Payload", payload);
     post("/items", payload).then(ret => this.setState({
      ...this.state,
      data: [].concat(this.state.data, [ret])
     }));
  }

  handleEditCell(row, name, value) {
    console.log(JSON.stringify(row));
    update("/items/", row, this.props.authenticity_token).then(console.log);
  }

  handleDeleteRow(rowKeys) {
    Promise.all(rowKeys.map(it => delete_("/items/", it, this.props.authenticity_token)))
      .then(rows => console.log(`Deleted ${rows.length} objects`));
  }
  
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
        blurToSave: true,
        afterSaveCell: this.handleEditCell,
      };

      const selectRowProp = {
        mode: 'checkbox',
        showOnlySelected: true
      };

      const itemType = this.props.item_types.reduce((obj, {id, name}) => (obj[id] = name, obj), {});

      function enumFormatter(cell, row, enumObject) {
        return enumObject[cell];
      }

      function imageFormatter(cell, row){
        if(cell == null) 
          cell = "/assets/add_picture.png";
        return (<img style={{width:25}} src={cell}/>)
      }

      const createImageEditor = (onUpdate, props) => (<ImageEditor onUpdate={ onUpdate } {...props}/>);

      const options = {
        clearSearch: true,

        page: 1,  // which page you want to show as default
        sizePerPageList: [ {
          text: '10', value: 10
        },{
          text: '15', value: 15
        },{
          text: '20', value: 20
        }, {
          text: 'All', value: this.state.data.length
        } ], // you can change the dropdown list for size per page
        sizePerPage: 15,  // which size per page you want to locate as default
        pageStartIndex: 1, // where to start counting the pages
        paginationSize: 5,  // the pagination bar size.
        prePage: 'Prev', // Previous page button text
        nextPage: 'Next', // Next page button text
        firstPage: 'First', // First page button text
        lastPage: 'Last', // Last page button text
        paginationShowsTotal: this.renderShowsTotal,  // Accept bool or function
        // hideSizePerPage: true > You can hide the dropdown for sizePerPage

        afterInsertRow: this.handleInsertedRow,
        afterDeleteRow: this.handleDeleteRow,
      };

      var  select_options = [
        { value: 'one', label: 'One' },
        { value: 'two', label: 'Two' }
      ];

      var select_options_it =   this.props.item_types.map(it => ( {value: it.id, label: it.name}));
      

      const logChange = val => {
        this.setState({...this.state, select_value: val})
        console.log("Selected: ", val) ;
      }
   
      //console.log(select_options_it); 
      //<TableHeaderColumn datafield="image_url" dataFormat={imageFormatter} 
      //              customEditor={ { getElement: createImageEditor } }>Image</TableHeaderColumn>

      // filter data
      const selected_item_types = this.state.select_value.map(it => it.value);

      const filtered_data = selected_item_types.length > 0 ? this.state.data.filter(it => selected_item_types.includes(it.item_type_id)) : this.state.data;

    	return (
    	 		<div className="Items col-md-10">
            <h2>Items</h2>
            <Select.Creatable
              name="item-type-select"
              multi
              width="50"
              value="one"
              value={this.state.select_value}
              options={  select_options_it }
              onChange={logChange}
            />
         
       	    <BootstrapTable data={filtered_data} 
                    exportCSV striped cellEdit={ cellEditProp } hover condensed 
                    search insertRow deleteRow selectRow={ selectRowProp } 
                    pagination options={ options }>
               <TableHeaderColumn dataField="id" isKey  autoValue dataAlign="center" hidden width="50" dataSort editable={false}>Item Id</TableHeaderColumn>
               <TableHeaderColumn datafield="image_url" width="50"dataFormat={imageFormatter} 
                    customEditor={ { getElement: createImageEditor } }>Image</TableHeaderColumn>
               <TableHeaderColumn dataField="item_type_id" width="80" dataSort  dataFormat={ this.itemTypeFormatter } 
                                  filterFormatted dataFormat={ enumFormatter } editable={ { type: 'select', options: { values: this.props.item_types.map(it => it.id) } } }
                formatExtraData={ itemType } csvHeader='item_type'csvFormat={ this.itemTypeFormatter }>
               Item Type</TableHeaderColumn>
               <TableHeaderColumn dataField="name" width="200" dataSort >Item Name</TableHeaderColumn>
               <TableHeaderColumn dataField="description" width="150">Item Description</TableHeaderColumn>
               <TableHeaderColumn dataField="created_at" width="100" dataFormat={ this.dateFormatter } dataSort editable={false} >Created at</TableHeaderColumn>
             </BootstrapTable>
          </div>
  	   );
  	};
}
