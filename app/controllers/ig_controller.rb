class IgController < ApplicationController

  require 'json'
  require 'httparty'

  def post_promociones

  	if(params['hub.challenge'] != nil) #perfecto

      render body: params['hub.challenge'].to_s
  		#respond_to do |format|
			#format.json { render text: params['hub.challenge'], status: 200}


  	else
  		IgManager.tag(params)
  		respond_to do |format|
			format.json { render json: {} ,status: 200}
		end

  	end
  
  end


end
