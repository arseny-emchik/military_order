MilitaryOrder::Application.routes.draw do
  resources :timetables, except: [:show] do
    post :ajax_load_form, on: :collection
  end
  resources :soldiers, except: [:show]
  resources :schedules, except: [:show]
  resources :settings, except: [:show]

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users/:id' => 'devise/registrations#update', :as => 'user_registration' # temp
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

end
