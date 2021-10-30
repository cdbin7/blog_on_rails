Rails.application.routes.draw do

  get('/', {to: 'posts#index', as: 'root'})
  
  resources :posts do
    resources :comments, only:[:create, :destroy]
  end

  resources :users, only:[:new, :create, :edit, :update] do
    get('/edit_password', {to: 'users#edit_password', as: 'edit_password'})
    patch('/edit_password', {to: 'users#update_password'})
  end


  resource :session, only:[:new, :create, :destroy]


end
