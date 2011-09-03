Lunchlady::Application.routes.draw do
  root :to => "special_pages#homepage"

  resources :meals, :only => [:index, :show, :edit, :update, :destroy] do
    resources :orders
  end
  match 'meals/:id/done' => 'meals#done', :as => 'meal_done'

  match 'restaurants/dump' => 'restaurants#dump'
  resources :restaurants do
    post :rate, :on => :member
  end

  devise_for :user, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' } do
    resources :users, :only => [:index, :show]
  end

  match 'admin/grid' => 'special_pages#grid'
  match 'admin/text' => 'special_pages#text'
end
