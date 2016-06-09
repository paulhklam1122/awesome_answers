Rails.application.routes.draw do
  # this defines a route that specifies if we get a request that has a GET HTTP verb with '/about' url, use the HomeController with about action (method)
  get "/about" => "home#about"

  # passing the 'as:' option enables us to have a url/path helper for this route
  #note that helpers are only for the URL portion of the route and have nothing to do with the HTTP Verb.
  # Also, note that a URL helper must be unique
  get "/greet/:name" => "home#greet", as: :greet
  root "home#index"
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
