class OperationController < ApplicationController

	def register
	# car_number, lat, long
		if !params[:car_number] || !params[:lat] || !params[:long]
			message = "Invalid registration, try again!"
		else
			correct_params={}
			correct_params[:car_number]=params[:car_number].upcase
			correct_params[:lat]=params[:lat]
			correct_params[:long]=params[:long]
      @blocking_client = BlockingClient.new(correct_params)
      if @blocking_client.save    
				message = @blocking_client[:blocking_client_id]
			else
				message = "An error occured during registration, try again!"
			end
		end
		respond_to do |format|
        format.json { render json: message}
    end
	end
	
	def get_messages
	# blocking_client_id
		if !params[:blocking_client_id]
			message = "Invalid get messages call, try again!"
		else
			begin
				@blocking_client = BlockingClient.find(params[:blocking_client_id])
				@messages = @blocking_client.messages
				nr_msg = 0
				msg_text = ""
				@messages.each do |msg|
					if msg.unread
						msg_text+=msg.message_text+" -> posted at "+msg.created_at.to_s+"\n"
						nr_msg=nr_msg+1
						msg.unread = false
						msg.save
					end
				end
				if nr_msg > 0
					message = "You have "+nr_msg.to_s+" new notifications: \n"+msg_text
				else
					message = "You have no new notifications!"
				end
			rescue
				message = "An error occured during get messages, try again!"
			end
		end
		respond_to do |format|
        format.json { render json: message}
    end
	end
	
	def unregister
	# blocking_client_id
		if !params[:blocking_client_id]
			message = "Invalid unregistration, try again!"
		else
			begin
				@blocking_client = BlockingClient.find(params[:blocking_client_id])
				@messages = @blocking_client.messages
				@messages.each do |message|
					message.destroy
				end
				@blocking_client.destroy
				message = "Unregistered!"
			rescue
				message = "An error occured during unregistration, try again!"
			end
		end
		respond_to do |format|
        format.json { render json: message}
    end
	end
	
	def search
	#car_number, lat, long
		if !params[:car_number] || !params[:lat] || !params[:long]
			message = "Invalid search parameters, try again!"
		else
			@notified = false
			BlockingClient.all.each do |car|
				if car.car_number == params[:car_number].upcase and distance([params[:lat].to_f, params[:long].to_f], [car.lat, car.long]) < 1000
					correct_params={}
					correct_params[:blocking_client_id]=car.blocking_client_id
					correct_params[:message_text]="You are blocking someone!"
					correct_params[:unread]=true
					@message = Message.new(correct_params)
				  if @message.save    
						@notified = true
					end
				end
			end
			if @notified
				message = "The person was notified!"
			else
				message = "No registered cars with the number were found in the area!"
			end
		end
		respond_to do |format|
        format.json { render json: message}
    end
	end
	
	private
		#http://stackoverflow.com/questions/12966638/rails-how-to-calculate-the-distance-of-two-gps-coordinates-without-having-to-u
		def distance a, b
			rad_per_deg = Math::PI/180  # PI / 180
			rkm = 6371                  # Earth radius in kilometers
			rm = rkm * 1000             # Radius in meters

			dlon_rad = (b[1]-a[1]) * rad_per_deg  # Delta, converted to rad
			dlat_rad = (b[0]-a[0]) * rad_per_deg

			lat1_rad, lon1_rad = a.map! {|i| i * rad_per_deg }
			lat2_rad, lon2_rad = b.map! {|i| i * rad_per_deg }

			a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
			c = 2 * Math.asin(Math.sqrt(a))

			rm * c # Delta in meters
		end
end
