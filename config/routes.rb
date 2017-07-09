Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'app/list'
  get 'app/create'
  get 'app/update/:appId/:version' => 'app#update'
  
  get '/' => redirect('app/list')
  get '*path' => redirect('app/list')

  namespace :api do
  	post 'app/list'
    post 'app/create'
    post 'app/update'
    post 'app/delete'
    post 'app/publish'
    post 'app/status'
    post 'upload' => 'app#upload'
  end
end