import {BootstrapTable, TableHeaderColumn} from 'react-bootstrap-table';

class Items extends React.Component {

	constructor(props) {
		super(props);
    this.state = {editmode: "hidden", recordkey: "", data: props.data};
    this.handleAddRecord = this.handleAddRecord.bind(this);
    this.handleEditEvent = this.handleEditEvent.bind(this);
	};

  handleAddRecord(e) {
    this.setState({editmode: "new"});
  }

  handleEditEvent(app_event, payload) {
    if(app_event == "exit") {
      this.setState({editmode: "hidden", recordkey: ""})   
    } else if(app_event == "add") {
        console.log("Will save data: " + JSON.stringify(payload, null, "\t") );
         $.ajax({
           data: payload,
           url: "/records",
           type: "POST",
           dataType: "json",
           success: data => {
             this.setState({data: this.state.data.concat(data) });
           }})
    } else if(app_event == "delete") {
      console.log("Will delete data: " + JSON.stringify(payload, null, "\t") );
      $.ajax({
           data: payload,
           url: "/records/"+ payload.id,
           type: "DELETE",
           dataType: "json",
           success: data => {
            console.log("Delete succedeed");
            const deleted_id = parseInt(payload.id,10);
            this.setState({data: this.state.data.filter(({ id }) => id !== deleted_id)});
           }})

    } else if(app_event == "edit"){
      console.log("Start edit data: " + JSON.stringify(payload, null, "\t") );
      this.setState({editmode: "edit", recordkey: payload.id})
      //console.log("handleEditEvent: " + app_event);
    } else if(app_event == "save") {
        console.log("Saving data: " + JSON.stringify(payload, null, "\t") );
        this.setState({editmode: "hiddden", recordkey: ""});
    }


  }


 
	render() {

      if(this.state.editmode == "hidden") {
        editpane =  <button  id="add" className="btn-xs btn-primary" onClick={this.handleAddRecord}>Add Record</button>;
      } else {
        editpane =  <button  id="add" className="btn-xs btn-primary" onClick={this.handleAddRecord}>Add Record</button>;
        //editpane =  <Record onEditEvent={this.handleEditEvent} authenticity_token={this.props.authenticity_token} />;
      };

      // "<RecordList data={this.state.data}  onEditEvent={this.handleEditEvent}/>
    	return (
    	 		<div className="Items col-md-6">
       			<h2 className="title">Records</h2>
       			{editpane}
       			
      		</div>
    	 );
  	};
}
