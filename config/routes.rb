Rails.application.routes.draw do
  resource  :sessions,  only: [:create, :destroy]
  resources :campaigns, only: [:index, :show, :create, :update, :destroy]

  post '/signup' => 'sessions#signup'
  post '/recovery' => 'sessions#recovery'
  get '/viewcampaigns' => 'campaigns#viewcampaigns'
  get '/viewcampaign/:id' => 'campaigns#viewcampaign'

  match "/*path",
    to: proc {
      [
        204,
        {
          "Content-Type"                 => "text/plain",
          "Access-Control-Allow-Origin"  => CORS_ALLOW_ORIGIN,
          "Access-Control-Allow-Methods" => CORS_ALLOW_METHODS,
          "Access-Control-Allow-Headers" => CORS_ALLOW_HEADERS
        },
        []
      ]
    }, via: [:options, :head]

end
