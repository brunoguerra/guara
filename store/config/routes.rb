Guara::Core::Engine.routes.prepend do
 
  match "/stock",    to: "stock#dashboard"

  match "/multiselect_categories_products", :to => 'products#multiselect_categories_products'

  resources :orders_in
  resources :orders_out
  resources :supplier
  resources :products


  #mount Spree::Core::Engine, :at => '/ecom'
  
end
