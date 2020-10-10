Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  resources :items do 
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :users, only: [] do
    collection do
      get 'mypage'
      get 'identification'
      resources :credit_cards, only:[:new, :show, :create, :destroy]
    end
  end
end
