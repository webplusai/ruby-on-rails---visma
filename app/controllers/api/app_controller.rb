class Api::AppController < ApplicationController

	require 'net/http'
	require 'rest-client'

	def list

	end

	def create
		puts "AAA"
	end

	def update

	end

	def show

	end

	def upload
		file = params[:file]

		result = ActiveSupport::JSON.decode( RestClient.post($base_url + '/v2/files', { :file => File.new(file.path) }, { :Authorization => $auth }) )
		render :plain => result['fileUrl']
		
		# url = URI.parse($base_url + '/v2/files')
		# http = Net::HTTP.new(url.host, url.port)
		# http.use_ssl = true

		# req = Net::HTTP::Post.new(url.to_s, initheader={'Content-Type' => 'multipart/form-data', 'Authorization' => $auth})
		# req.body = File.new(file.path)

		# #puts File.new(file.path)

		# res = Net::HTTP.start(url.host, url.port) { |http|
		# 	http.request(req);
		# }

	end
end
