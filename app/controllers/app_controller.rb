class AppController < ApplicationController

	def list
		require 'net/http'

		url = URI.parse('https://sandbox-market.openchannel.io' + "/v2/apps/versions?developerId=1&query=" + '{$or: [{"status.value":"rejected",isLatestVersion:true},{isLive:true},{"status.value":{$in:["inDevelopment","inReview","pending"]}}]}')
		http = Net::HTTP.new(url.host, url.port)
		user = '5463cee5e4b042e3e26f1e41'
		pass = 'E2lWmPmaADbXm3buLFr4vPa10FVm7M501XOtIMFjJBM'
		auth = ActionController::HttpAuthentication::Basic.encode_credentials(user, pass)
		req = Net::HTTP::Get.new(url.to_s, initheader = {'Content-Type' => 'application/json', 'Authorization' => auth})
		http.use_ssl = true

		res = Net::HTTP.start(url.host, url.port) {|https|
			http.request(req)
		}
		puts res.body
	end

	def create

	end

	def update

	end
end
