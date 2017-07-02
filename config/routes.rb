Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'app/list'
  get 'app/create'
  get 'app/update'

  namespace :api do
  	post 'app/list'
	post 'app/create'
	post 'app/update'
  end
end