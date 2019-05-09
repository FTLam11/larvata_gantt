LarvataGantt::Engine.routes.draw do
  resources :entities, only: [:index, :show]
  resources :link, defaults: { format: :json }, only: [:create, :update, :destroy]
  resources :task, defaults: { format: :json }, only: [:create, :update, :destroy]
end
