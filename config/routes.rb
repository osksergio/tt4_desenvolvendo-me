Rails.application.routes.draw do
  resources :titles
  post 'titles/import_csv', to: 'titles#import_csv'
  get 'titles/method_test', to: 'titles#method_test'
end
