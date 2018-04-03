Rails.application.routes.draw do
  resources :onlineforms
  resources :evangelists, param: :title, :path => 'material' do
    resources :conversations
    resources :likes
    get :index_new, :on => :collection, :path => 'newest'
    get :index_comment, :on => :collection, :rank => 'comment'
    get :search, :on => :collection
    get :search_new, :on => :collection
    get :search_rank, :on => :collection
    post :yt, :on => :collection
    get :repeat, :on => :member
    post :play_this, :on => :collection
    post :index_cate
  end

  post :upload_image, to: 'uploads#upload_image'
  # match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :post]

  get 'm/:title', to: 'evangelists#redirection', as: "m"

  get :vocaloid, to: 'evangelists#vocaloid', as: "vocaloid"
  get :anisong_eroge, to: 'evangelists#anisong_eroge', as: "anisong_eroge"
  get :anisong_hu, to: 'evangelists#anisong_hu', as: "anisong_hu", :path => 'game'
  get :anisong_ippan, to: 'evangelists#anisong_ippan', as: "anisong_ippan"
  get :touhou, to: 'evangelists#touhou', as: "touhou"
  get :game_music, to: 'evangelists#game_music', as: "game_music"
  get :mad, to: 'evangelists#mad', as: "mad"
  get :omairano_konomi, to: 'evangelists#omairano_konomi', as: "omairano_konomi"
  get :jikkyou, to: 'evangelists#jikkyou', as: "jikkyou"
  get :reino_are, to: 'evangelists#reino_are', as: "reino_are"
  get :tech, to: 'evangelists#tech', as: "tech"

  # resources :speaks
  get 'categories/:category', to: 'evangelists#index', as: "category"
  get 'categories_new/:category', to: 'evangelists#category_new', as: "category_new"
  get 'categories_comment/:category', to: 'evangelists#category_comment', as: "category_comment"
  resources :ucategorization, :path => 'cate', as:"cate"
  resources :bantags, :path => 'ban', as:"ban"
  resources :playlists do
    post :add
    post :remove
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

devise_for :users, controllers: {
  omniauth_callbacks: "omniauth_callbacks"
  # sessions: 'users/sessions'
  # registrations: 'users/registrations'
}


  get 'how_to_use' => 'pages#how_to_use', as: :how_to_use
  get 'terms' => 'pages#terms', as: :terms
  get 'dmca' => 'pages#dmca', as: :dmca
  # get 'fordevelopers' => 'pages#fordevelopers'
  # get 'forevangelists' => 'pages#forevangelists'
  # get 'credit' => 'pages#credit'
  # get 'guidelines' => 'pages#guidelines'
  # get 'privacy' => 'pages#privacy'

  # get 'demo/:id' => 'photos#show'
  get 'tags/:tag', to: 'evangelists#index', as: :tag
  # resources :demos do
  #   member do
  #     get 'download'
  #     get 'download_demo'
  #   end
    # resources :comments, except: :index
  #   resources :funds, except: [:index,:show]
  #   resources :charges, except:[:index, :show]
  # end

  resources :users do
    resources :charges, except:[:index, :show] do
      post :plan, :on => :collection
      post :unsubscribe, :on => :collection
    end
    post :post_update, on: :member
    resources :relationships,       only: [:create, :destroy]
    # post :hi, :on => :collection
    # resources :mikutalks do
    #   member do
    #     patch 'similar', :as => :similar
    #     patch 'oneof', :as => :oneof
    #   end
    # end
  end

  # resources :words

  # get 'chat/index'

  # You can have the root of your site routed with "root"
  # match '/:locale' => 'evangelists#index', via: [:get], :as => 'locale_root'
   root 'evangelists#index'
end