Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => 'user/registrations'}

  root :to => 'welcome#index'

  get 'my-portfolio',  :to => 'users#my_portfolio'
  get 'search-stocks', :to => 'stocks#search'

  resources :user_stocks, :only => [:create, :destroy]
end
