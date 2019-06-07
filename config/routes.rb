Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/quotations', to: 'quotations#index'
      get '/variation', to: 'quotations#variation'
      get '/fetch_quotations', to: 'quotations#fetch_quotations'
    end
  end
end

