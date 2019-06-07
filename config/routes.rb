Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/quotations', to: 'quotations#index'
      get '/variation', to: 'quotations#variation'
    end
  end
end

