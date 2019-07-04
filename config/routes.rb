Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/search', to: 'searches#new'
  post '/search', to: 'searches#show'

  get '/nykapi', to: 'sinoiov#show'
  post '/nykapi', to: 'sinoiov#show'
end
