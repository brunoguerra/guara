Guara::Core::Engine.routes.prepend do
  resources :products
  
  mount Spree::Core::Engine, :at => '/ecom'
end
