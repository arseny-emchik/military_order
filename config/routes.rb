MilitaryOrder::Application.routes.draw do
  resources :timetables, except: [:show] do
    post :ajax_load_form, on: :collection
  end

  get 'csv' => 'timetables#export_csv', :as => :csv

  resources :soldiers, except: [:show]
  resources :settings, except: [:show]

  devise_for :users
  as :user do
    root to: 'devise/sessions#new'
  end
end
