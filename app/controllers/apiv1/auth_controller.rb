class Apiv1::AuthController < ApplicationController
  def gettoken
  	  @token = {token: "0123456789"} 
  end

  def renewtoken
  end

  def verifytoken
  end
end
