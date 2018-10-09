Rails.application.routes.draw do
  use_doorkeeper do
    # No need to register client application
    skip_controllers :applications, :authorized_applications
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { sessions: "users/sessions" }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users
      resources :companies
      resources :registrations
    end
  end
  post    'api/v1/sessions'  => 'doorkeeper/tokens#create'
  delete  'api/v1/sessions'  => 'doorkeeper/tokens#revoke'
  post    'api/v1/check_in'  => 'api/v1/registrations#create'
  put     'api/v1/check_out/:id' => 'api/v1/registrations#update'
end
