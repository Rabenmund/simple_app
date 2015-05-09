SimpleApp::Application.routes.draw do

  root to: 'federations#index'
  resources :federations, except: [:destroy] do
    resources :teams, except: [:index, :destroy]
  end

  resources :seasons, only: [:index, :show]
  resources :leagues, only: [:show]
  resources :cups, only: [:show]
  resources :matchdays, only: [:show] do
    member do
      get :perform
    end
    resource :draw, only: [:show] do
      get :perform
    end
  end

end
