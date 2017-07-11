class Api::AppController < ApplicationController

	require 'net/http'
	require 'rest-client'

	# Create app route
	def create

		body = {
			'developerId' => $developer_id,
			'name' => params[:name],
			'customData' => params
		}

		url = URI.parse($base_url + '/v2/apps')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => $auth})
		req.body = ActiveSupport::JSON.encode(body)
		res = Net::HTTP.start(url.host, url.port) { |https|
			http.request(req)
		}

		res = ActiveSupport::JSON.decode(res.body)
		
		# If error was returned, display error message and return
		if res['code'] != nil
			session[:toast_type] = 'error'
			session[:toast_message] = res['errors'][0]['message']
			redirect_to '/app/create'
			return
		end

		# App should be published
		if params[:publish] == 'true'
			body = {
				'developerId' => $developer_id,
				'version' => res['version']
			}

			# Publish the created app
			url = URI.parse($base_url + '/v2/apps/' + res['appId'] + '/publish')
			req = Net::HTTP::Post.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => $auth})
			req.body = ActiveSupport::JSON.encode(body)
			res = Net::HTTP.start(url.host, url.port) { |https|
				http.request(req)
			}

			res = ActiveSupport::JSON.decode(res.body)
			# If error was retrieved, display error message and return
			if res['code'] != nil
				session[:toast_type] = 'error';
				session[:toast_message] = 'There was an error publishing the app. Please try again'
				redirect_to '/app/list'
				return
			end

			# Display success message
			session[:toast_type] = 'publish';
			redirect_to '/app/list'
			return
		end

		# App should be published later
		# Display success message
		session[:toast_type] = 'create';
		redirect_to '/app/list'
	end

	# Update app route
	def update
		body = {
			'developerId' => $developer_id,
			'name' => params[:name],
			'customData' => params
		}

		url = URI.parse($base_url + '/v2/apps/' + params[:appId] + '/versions/' + params[:version])
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => $auth})
		req.body = ActiveSupport::JSON.encode(body)
		res = Net::HTTP.start(url.host, url.port) { |https|
			http.request(req)
		}

		res = ActiveSupport::JSON.decode(res.body)

		# If error was retrieved, display error message and return
		if res['code'] != nil
			session[:toast_type] = 'error'
			session[:toast_message] = res['errors'][0]['message']
			redirect_to '/app/update/' + params[:appId] + '/' + params[:version];
			return
		end

		# App should be published
		if params[:publish] == 'true'
			body = {
				'developerId' => $developer_id,
				'version' => res['version']
			}

			# Publish the app after editing
			url = URI.parse($base_url + '/v2/apps/' + res['appId'] + '/publish')
			req = Net::HTTP::Post.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => $auth})
			req.body = ActiveSupport::JSON.encode(body)
			res = Net::HTTP.start(url.host, url.port) { |https|
				http.request(req)
			}

			res = ActiveSupport::JSON.decode(res.body)

			# If error is retreived, display error message and return
			if res['code'] != nil
				session[:toast_type] = 'error';
				session[:toast_message] = 'There was an error publishing the app. Please try again later'
				redirect_to '/app/list'
				return
			end

			# Display success message
			session[:toast_type] = 'publish';
			redirect_to '/app/list'
			return
		end

		# App should be published later
		# Display success message
		session[:toast_type] = 'update';
		redirect_to '/app/list'
	end

	# Publish app route
	def publish
		body = {
			'developerId' => $developer_id,
			'version' => params[:version].to_i
		}

		# Publish app
		url = URI.parse($base_url + '/v2/apps/' + params[:appId] + '/publish')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => $auth})
		req.body = ActiveSupport::JSON.encode(body)
		res = Net::HTTP.start(url.host, url.port) { |https|
			http.request(req)
		}

		res = ActiveSupport::JSON.decode(res.body)

		# If error is retrieved, display error message and return
		if res['code'] != nil
			session[:toast_type] = 'error';
			session[:toast_message] = 'There was an error publshing the app. Please try again later'
			redirect_to '/app/list'
			return
		end

		# Display success message
		session[:toast_type] = 'publish';
	end

	# Delete app route
	def delete

		# If version is set, delete that version
		if params[:version] != nil
			url = URI.parse($base_url + '/v2/apps/' + params[:appId] + '/versions/' + params[:version].to_s + '?developerId=' + $developer_id)
		# If version is not set, delete all app versions	
		else
			url = URI.parse($base_url + '/v2/apps/' + params[:appId] + '?developerId=' + $developer_id)
		end

		# Delete app
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Delete.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => $auth})
		res = Net::HTTP.start(url.host, url.port) { |https|
			http.request(req)
		}

		res = ActiveSupport::JSON.decode(res.body)

		# If error is retrieved, display error message and return
		if res['code'] != nil
			session[:toast_type] = 'error'
			session[:toast_message] = res['errors'][0]['message']
			redirect_to '/app/list'
			return
		end

		# Display success message
		session[:toast_type] = 'delete';
	end

	# Suspend or unsuspend route
	def status
		body = {
			'developerId' => $developer_id,
			'status' => params[:status]
		}

		url = URI.parse($base_url + '/v2/apps/' + params[:appId] + '/status')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => $auth})
		req.body = ActiveSupport::JSON.encode(body)
		res = Net::HTTP.start(url.host, url.port) { |https|
			http.request(req)
		}
		
		res = ActiveSupport::JSON.decode(res.body)

		# If error is retrieved, display error message and return
		if res['code'] != nil
			session[:toast_type] = 'error'
			session[:toast_message] = res['errors'][0]['message']
			redirect_to '/app/list'
			return
		end

		# Display success message
		session[:toast_type] = 'status'
		session[:toast_message] = 'App ' + params[:status] + 'ed successfully'
	end

	# File upload route
	def upload
		file = params[:file]

		result = ActiveSupport::JSON.decode( RestClient.post($base_url + '/v2/files', { :file => File.new(file.path) }, { :Authorization => $auth }) )
		render :plain => result['fileUrl']
	end
end
