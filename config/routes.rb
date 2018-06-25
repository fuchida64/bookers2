Rails.application.routes.draw do
  devise_for :users
  get '/' =>'home#index'
  get '/about' =>'home#show'
  delete '/posts/:id' => 'posts#destroy', as: 'destroy'
  resources :users, only: [:show, :index, :edit, :update]
  resources :posts, only: [:create, :index, :show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Refile.secret_key = '548ae931b9443b2d1cd395abe60e09bcc659b461fbfef45af47d85ff4f5c67cac036a2220071185de6be11d5a7e440e8fa453bcf7da424ff8cddaf61e7b8a3e5'