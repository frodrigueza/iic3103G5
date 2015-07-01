Rails.application.routes.draw do

  devise_for :users

  namespace :dashboards do
    get 'warehouses'
    get 'orders'
    get 'orders_by_sku_group_by_canal'
    get 'orders_by_created_at_date'
    get 'quantities_by_sku_group_by_canal'
    get 'social'
  end

  match 'pedidos/(:id)' => 'pedidos#index', via: :get

  namespace :ig do
    post 'post_promociones'
    get 'post_promociones'
  end

  namespace :b2b do
    get 'documentation'
    put 'new_user'
    post 'get_token'
    post 'new_order'
    post 'order_accepted'
    post 'order_canceled'
    post 'order_rejected'
    post 'invoice_created'
    post 'invoice_paid'
    post 'invoice_rejected'
  end

  namespace :orders do
    get 'check_pedidos'
    get 'check_ftp'
    get 'clear_pedidos'
    get 'clear_logs'
    get 'clear_insumos'
  end

  namespace :b2c do
    get 'comprar'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'b2c#index'

  match ':controller/(:action/(:id))', via: [:get, :post]

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
