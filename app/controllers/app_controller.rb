class AppController < ApplicationController

	require 'net/http'
require "uri"
require "net/http"

params = {'box1' => 'Nothing is less important than which fork you use. Etiquette is the science of living. It embraces everything. It is ethics. It is honor. -Emily Post',
'button1' => 'Submit'
}
x = Net::HTTP.post_form(URI.parse('http://www.interlacken.com/webdbdev/ch05/formpost.asp'), params)
puts x.body
	def list

		data = {}
		url = URI.parse('https://sandbox.openchannel.io')
		req = Net::HTTP::get.new(url.to_s, data)
# url = URI.parse('http://www.example.com/index.html')
# req = Net::HTTP::Get.new(url.to_s)
# res = Net::HTTP.start(url.host, url.port) {|http|
#   http.request(req)
# }
# puts res.body
	end

	def create

	end

	def update

	end
end
