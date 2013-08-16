Dummy::Application.routes.draw do
  #root to: 'guara/static_pages#home'
  mount Guara::Core::Engine, at: "/"
end
