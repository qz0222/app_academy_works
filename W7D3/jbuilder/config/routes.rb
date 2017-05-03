Rails.application.routes.draw do
 # Your routes here!

 namespace :api, defaults: {format: :json} do
   resources :guests do
     resources :gifts, only: [:index]
   end
   resources :gifts, only: [:show]
   resources :parties, only: [:index, :show]
 end
end
