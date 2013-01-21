Guara::Core::Engine.routes.prepend do
  resources :products
  
  match "/stock",    to: "stock#dashboard"
  
  resources :orders_in
  resources :orders_out
  
  mount Spree::Core::Engine, :at => '/ecom'
  
end
