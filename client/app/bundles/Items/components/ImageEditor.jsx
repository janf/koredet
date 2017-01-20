import React from 'react';

import ReactS3Uploader from 'react-s3-uploader';

export default class ImageEditor extends React.Component {
  constructor(props) {
    super(props);
    this.updateData = this.updateData.bind(this);
    this.onUploadStart = this.onUploadStart.bind(this);
    this.onUploadFinish = this.onUploadFinish.bind(this);
    this.state = { 
      image_url: props.defaultValue,
      open: true
    };
    console.log("IE constructor")
  }

  focus() {
    //this.refs.inputRef.focus();
  }

  onUploadStart(file, next) {
    console.log("Props: " + JSON.stringify(this.uploader.getInputProps()));
    next(file);
  }

  updateData() {
    this.props.onUpdate({ image_url: this.state.image_url} );
  }

  onUploadFinish(event) {
    var result = event;
    

    console.log("Result"+ JSON.stringify(result));
  
    var res = result.signedUrl;

    console.log("SignedUrl: "+ res);

    var url = res.split("?");

    console.log("Image URL: " + url[0]);
    
    
    //console.log("Signed URL "+ event.target.value);
    this.setState( {image_url: url[0]});
    this.props.onUpdate( this.state.image_url );
    this.setState({ open: false });
  }

  close = () => {
    this.setState({ open: false });
    this.props.onUpdate(this.props.defaultValue);
  }



  render() {
    return (
      <span>
        <ReactS3Uploader
          ref = {(input) => { this.uploader = input }}
          signingUrl="/apiv1/image/image_sign_url"
          accept="image/*"
          preprocess={this.onUploadStart}
          onProgress={this.onUploadProgress}
          onError={this.onUploadError}
          onFinish={this.onUploadFinish}
          uploadRequestHeaders={{ 'x-amz-acl': 'public-read' }}
          contentDisposition="auto" />
      </span>
    );
  }
}
