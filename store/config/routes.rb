Guara::Core::Engine.routes.prepend do
  resources :products
  
  match "/stock",    to: "stock#dashboard"
  
  mount Spree::Core::Engine, :at => '/ecom'
  
end
