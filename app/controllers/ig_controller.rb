class IgController < ApplicationController

  require 'json'
  require 'httparty'

  def post_promociones

  	if(params['hub.challenge'] != nil) #perfecto

  		respond_to do |format|
			format.json { render json: params['hub.challenge'], status: 200}
		end

  	else
  		IgManager.tag(params)
  		respond_to do |format|
			format.json { render json: {} ,status: 200}
		end

  	end
  
  end


end
