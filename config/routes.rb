LarvataGantt::Engine.routes.draw do
  resources :portfolios, except: [:new, :edit]
  resources :link, only: [:create, :update, :destroy]
end
