import React from 'react';

import ReactS3Uploader from 'react-s3-uploader';

export default class ImageEditor extends React.Component {
  constructor(props) {
    super(props);
    this.updateData = this.updateData.bind(this);
    this.state = { image_url: props.defaultValue.amount };
  }

  focus() {
    //this.refs.inputRef.focus();
  }
  updateData() {
    this.props.onUpdate({ image_url: this.state.image_url} );
  }
  render() {
    return (
      <span>
        <ReactS3Uploader
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
