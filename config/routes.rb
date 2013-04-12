Newcreators::Application.routes.draw do

  get "/design" => "design#index"

  root to: 'home#index'

  #sortable
  put "sortable/update_order" => "sortable#update_order"

  # PORTFOLIO
  post '/creators/send_portfolio' => 'creators#send_portfolio', as: :send_portfolio
  get '/portfolios' => 'creators#portfolios', as: :portfolios

  # PAGES
  get '/pages/:id/new' => 'pages#new', as: :new_page
  get '/pages/:id/edit' => 'pages#edit', as: :edit_page

  post '/pages' => 'pages#create'
  put '/pages/:id' => 'pages#update'
  delete '/pages/:id' => 'pages#destroy', as: :page

  # CATEGORIES
  get '/category/:category_id' => 'categories#show', as: :category

  # SEARCH
  get '/search/creators' => 'search#index', as: :search_creators, resource: "creator"
  get '/search/inspirations' => 'search#index', as: :search_inspirations, resource: "inspiration"

  # CREATOR
  post '/creator/second_step/:id' => 'creators#step2', as: :creator_step2


  resources :mines do
    resources :products
  end

  resources :inspirations do
    get "/by_tag/:query", action: :by_tag, on: :collection, as: :by_tag
  end

  resources :creators do
    resources :galleries, except: :index
  end

  # DEVISE
  devise_for :users
  devise_scope :user do
    get "/publisher", :to => "devise/sessions#new"
  end
end
