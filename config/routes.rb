Rails.application.routes.draw do
  resources :titles
  post 'titles/import_csv', to: 'titles#import_csv'
end
