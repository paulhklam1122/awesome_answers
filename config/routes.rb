Rails.application.routes.draw do
  resources :votes
  # this defines a route that specifies if we get a request that has a GET HTTP verb with '/about' url, use the HomeController with about action (method)
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
  root "home#index"
  get "/about" => "home#about"

  # passing the 'as:' option enables us to have a url/path helper for this route
  #note that helpers are only for the URL portion of the route and have nothing to do with the HTTP Verb.
  # Also, note that a URL helper must be unique
  get "/greet/:name" => "home#greet", as: :greet

  resources :users, only: [:new, :create]

  get "/auth/twitter", as: :sign_in_with_twitter
  get "/auth/twitter/callback" => "callbacks#twitter"

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  # get "api/v1/questions" => "api/v1/questions#index"

  # this will prepend al the urls for the questions with /api/v1 but it will still point to the questions_controller.rb
  # scope :api do
  #   scope :v1 do
  #     resources :questions, only: [:index, :show]
  #   end
  # end

  # this will prepend al the urls for the questions with /api/v1 and it will point to the api/v1/quesitons_controller.rb
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :questions, only: [:index, :show] do
        resources :answers, only: [:create]
      end
    end
  end

  resources :questions do
    resources :votes, only: [:create, :update, :destroy]
    # this will define a route that will be '/questions/search' and it will
    # point to the questions controller 'search' action in that controller.
    # on: :collection makes the route not have an 'id' or 'question_id' on it
    get :search, on: :collection
    # this will generate a route '/questions/:id/flag' and it will point to
    # questions controller 'flag' action.
    # on: :member makes the route include an ':id' in it similar to the 'edit'
    post :flag, on: :member
    post :mark_done
    # will make all the answers routes nested within 'questions' which means all the answers routes will be prepended within
    # '/questions/:question_id'
    resources :answers, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :likes, only: [:index]
  # get "/questions/new" => "questions#new", as: :new_question
  # post "/questions" => "questions#create", as: :questions
  # get "/questions/:id" => "questions#show", as: :question
  # get "/questions" => "questions#index"
  # get "/questions/:id/edit" => "questions#edit", as: :edit_question
  # patch "/questions/:id/" => "questions#update"
  # delete "/questions/:id" => "questions#destroy"
  # root makes it your home page without adding any url
  get "/cowsay" => "cowsay#index"
  post "/cowsay" => "cowsay#create", as: :cowsay_submit
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get "/temperature_converter" => "temperature_converter#index"
  post "/temperature_converter" => "temperature_converter#create"
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  delete "/questions/:id" => "questions#destroy"
  get "/questions/:id/edit" => "questions#destroy"
  get "/questions/:id/" => "questions#show"
  post "/questions/:id/comments" => "comments#create"
  get "/faq" => "home#faq"

  get "/bill_splitter" => "bill_splitter#index"
  post "/bill_splitter" => "bill_splitter#split"
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get "name_picker" => "name_picker#index"
  post "name_picker" => "name_picker#pick"

  get "admin/questions" => "questions#index"

  namespace :admin do
    resources :questions
  end

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
