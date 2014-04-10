MilitaryOrder::Application.routes.draw do
  resources :timetables, except: [:show]
  resources :soldiers, except: [:show]
  resources :schedules, except: [:show]
  resources :settings, except: [:show]

  devise_for :users  # temp

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'
    root to: 'devise/sessions#new'
  end

end
