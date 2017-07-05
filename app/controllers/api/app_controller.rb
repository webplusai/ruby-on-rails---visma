class Api::AppController < ApplicationController

	require 'net/http'
	require 'rest-client'

	def list

	end

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

		res = ActiveSupport::JSON.decode(res.body);

		if params[:publish] = 'true'
			body = {
				'developerId' => $developer_id,
				'version' => res['version']
			}
			url = URI.parse($base_url + '/v2/apps/' + res['appId'] + '/publish')
			req = Net::HTTP::Post.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => $auth})
			req.body = ActiveSupport::JSON.encode(body)
			res = Net::HTTP.start(url.host, url.port) { |https|
				http.request(req)
			}

			puts res.body
		end

		redirect_to '/app/list'
	end

	def update

	end

	def publish
		body = {
			'developerId' => $developer_id,
			'version' => params[:version].to_i
		}
		url = URI.parse($base_url + '/v2/apps/' + params[:appId] + '/publish')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => $auth})
		req.body = ActiveSupport::JSON.encode(body)
		res = Net::HTTP.start(url.host, url.port) { |https|
			http.request(req)
		}

		puts res.body
	end

	def delete
		if params[:version] != nil
			url = URI.parse($base_url + '/v2/apps/' + params[:appId] + '/versions/' + params[:version].to_s + '?developerId=' + $developer_id)
		else
			url = URI.parse($base_url + '/v2/apps/' + params[:appId] + '?developerId=' + $developer_id)
		end

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Delete.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => $auth})
		res = Net::HTTP.start(url.host, url.port) { |https|
			http.request(req)
		}

		puts res.body
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
