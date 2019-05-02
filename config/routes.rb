LarvataGantt::Engine.routes.draw do
  resources :portfolios, except: [:new, :edit]
  resources :link, defaults: { format: :json }, only: [:create, :update, :destroy]
end
