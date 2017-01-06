class Apiv1::ImageController < ApplicationController


  def image_sign_url
	options = {path_style: true}
	headers = {"Content-Type" => params[:contentType], "x-amz-acl" => "public-read"}

	url = $storage.put_object_url('koredet-dev', "user_uploads/#{params[:objectName]}", 15.minutes.from_now.to_time.to_i, headers, options)

	puts "AWS url: " + url

	respond_to do |format|
	  	format.json { render json: {signedUrl: url} }
	end
  end

end
