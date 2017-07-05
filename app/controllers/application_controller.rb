class ApplicationController < ActionController::Base
	$base_url = 'https://sandbox-market.openchannel.io'
  	$marketplace_id = '5463cee5e4b042e3e26f1e41'
  	$secret = 'E2lWmPmaADbXm3buLFr4vPa10FVm7M501XOtIMFjJBM'
  	$auth = ActionController::HttpAuthentication::Basic.encode_credentials($marketplace_id, $secret)
  	$developer_id = '1'
	protect_from_forgery with: :exception
end
