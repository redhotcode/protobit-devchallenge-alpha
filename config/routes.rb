TasklistChallenge::Application.routes.draw do
  resources :tasks, except: [:show] do
    member do
      get 'complete'
      get 'archive'
    end
  end
  root 'tasks#index'

  get 'readme' => 'docs#readme', as: :readme
  get 'maps' => 'maps#show', as: :maps
end
