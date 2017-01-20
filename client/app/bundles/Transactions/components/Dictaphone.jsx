import React, { PropTypes, Component } from 'react'
import VoiceRecognition from './VoiceRecognition'
import { connect } from 'react-redux'
import { addTransactionItem } from '../actions'
import { parse_transaction_text } from '../../../lib/parsetext'




class Dictaphone extends Component {
  state = {
    start: true,
    stop: false
  }

  onEnd = () => {
    this.setState({ start: false, stop: false })
    console.log("End!");
  }

  onResult = ({ finalTranscript }) => {
    const result = finalTranscript

    //this.setState({ start: false })
    console.log("Final: " + finalTranscript);
    
    let parsed_text;
    parsed_text = parse_transaction_text(result);
    console.log("Parsed text: " + JSON.stringify(parsed_text));
    var action = addTransactionItem(parsed_text["item_name"], parsed_text["qty"]);
    console.log("action: " + JSON.stringify(action));
    this.props.dispatch(action);


  }

  render () {
    
    let renderSpeech;

    if(this.state.start) 
      renderSpeech = <button onClick={() => this.setState({ start: false })}>stop</button>;
    else      
      renderSpeech = <button onClick={() => this.setState({ start: true })}>start</button>;
    //    <button onClick={() => this.setState({ start: true })}>start</button>
    //    <button onClick={() => this.setState({ stop: true })}>stop</button>
    
    //onStart={this.props.action('start')}
    //        onEnd={this.props.action('end')}

    return (
      <div>
          {renderSpeech}
          {this.state.start && (
          <VoiceRecognition
            onEnd = {this.OnEnd}            
            onResult={this.onResult}
            continuous={true}
            lang="no-no"
            start={this.state.start}
            stop={!this.state.start}
          />
        )}
        
      </div>
    )
  }
}

//Dictaphone.propTypes = propTypes;

//onStart={console.log('start')}
//onEnd={console.log('end')}
          // onResult={this.onResult}
          // continuous={true}
          // stop={this.state.stop}
//
//<VoiceRecognition 
//          onResult={this.onResult}
//          start={this.state.start}
//          stop={this.state.stop}
//        />      

Dictaphone = connect()(Dictaphone);

export default Dictaphone;