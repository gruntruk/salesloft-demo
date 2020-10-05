Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#show'

  scope '/api' do
    resources :people, :only => [:index] do
      collection do 
        get 'frequency_count'
      end
    end
  end
end
