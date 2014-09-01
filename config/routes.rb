SwagDogsApi::Application.routes.draw do

  namespace :api do
    namespace :v0 do
      resources :dogs
    end
  end

end
