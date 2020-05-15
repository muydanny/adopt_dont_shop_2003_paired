Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get '/', to: 'welcome#index'

    get '/shelters', to: 'shelters#index'
    get '/shelters/new', to: 'shelters#new'
    post '/shelters', to: 'shelters#create'
    get '/shelters/:id', to: 'shelters#show'
    get '/shelters/:id/edit', to: 'shelters#edit'
    patch '/shelters/:id', to: 'shelters#update'
    delete '/shelters/:id', to: 'shelters#destroy'

    get '/shelters/:id/new_review', to: "reviews#new_review"
    post '/shelters/:id/review', to: "reviews#create"
    get '/shelters/:id/reviews/:review_id/edit', to: "reviews#edit"
    patch '/shelters/:id/reviews/:review_id', to: 'reviews#update'
    delete 'shelters/:id/reviews/:review_id', to: 'reviews#destroy'

    get '/pets', to: 'pets#index'
    get '/shelters/:id/pets', to: 'pets#index'
    get '/shelters/:id/pets/new', to: 'pets#new'
    post '/shelters/:id/pets', to: 'pets#create'

    get '/pets/:id', to: 'pets#show'
    get '/pets/:id/edit', to: 'pets#edit'
    patch '/pets/:id', to: 'pets#update'
    delete '/pets/:id', to: 'pets#destroy'
    patch '/pets/:id/pending', to: 'pets#is_pending'
    patch '/pets/:id/adoptable', to: 'pets#is_adoptable'

    get '/shelters/:id/pets', to: 'pets#index'
# Routes for Paired
    get '/favorites', to: 'favorites#index'
    patch '/favorites/:pet_id', to: 'favorites#update'
    delete '/favorites/:pet_id', to: 'favorites#destroy'
    delete '/favorites', to: 'favorites#destroy_all'

    get '/apps/new', to: 'apps#new'
    post '/apps', to: 'apps#create'
    get '/apps/:id', to: 'apps#show'





end
