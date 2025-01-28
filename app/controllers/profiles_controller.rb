class ProfilesController < ApplicationController
	def index
		profile = Profile.all
		if profile 
			render json: {data: profile}, status: :ok
		else
			render json: {error: profile.error.full_messages}, status: :unprocessable_entity
		end
	end
end