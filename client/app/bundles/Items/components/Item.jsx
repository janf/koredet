import React from 'react';


export default class Item extends React.Component {
	constructor(props) {
    	super(props);
    	this.state = {title: 'Hello',
    				  image_url: "",
    				  date: 'Today',
    				  amount: 1,
    				  addrecord: false
    				  };

    	this.handleTitleChange = this.handleTitleChange.bind(this);
    	this.handleDateChange = this.handleDateChange.bind(this);
    	this.handleAmountChange = this.handleAmountChange.bind(this);
    	this.handleImageUrlChange = this.handleImageUrlChange.bind(this);
    	this.handleSubmit = this.handleSubmit.bind(this)
    	this.handleExit = this.handleExit.bind(this)
	};

	handleTitleChange(e) {
		console.log("Title changed");
		this.setState({ title: e.target.value });
	}

	handleImageUrlChange(e) {
		console.log("Image url changed");
		this.setState({ title: e.target.value });
	}


	handleDateChange(e) {
		console.log("Date changed -");
		this.setState({ date: e.target.value });
	}

	handleAmountChange(e) {
		console.log("Amount changed -");
		this.setState({ amount: e.target.value });
	}

	handleSubmit(e) {
		console.log("Pressed submit, button: " + e.value);
		console.log("Should update record");
		payload = { record:  
				 		{title: this.state.title,
						date: this.state.date,
						amount: this.state.amount,
						image_url: this.state.image_url} };
		this.props.onEditEvent("add", payload);		
		e.preventDefault();
	}

	handleExit(e) {
		console.log("Pressed exit");
		console.log("Should notify parent about event");
		this.props.onEditEvent("exit");
		e.preventDefault();
	}


	render() {
    	 return (
    	  		<form className="form-inline"  method="post" onSubmit={this.handleSubmit}>
     				<div className="form-group"> 
     				    <label>
					    	Title:
					    	<input type="text" name="title" value={this.state.title} onChange={this.handleTitleChange} />
					    </label>
					    <label>
					    	Date:
					    	<input type="text"  name="date" value={this.state.date} onChange={this.handleDateChange} />
					    </label>
					    <label>
					    	Amount:
					    	<input type="text"  name="amount" value={this.state.amount} onChange={this.handleAmountChange} />
					    </label>
					    <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
					    <input type="submit" value="Add" className="btn-xs btn-primary" id="submit"/>
					    <button id="exit" className="btn-xs btn-warning" onClick={this.handleExit}>Exit</button>
     				</div>
      			</form>
    	 );
  	};
 
  	
};

