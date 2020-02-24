Rails.application.routes.draw do
  root "dashboard#index"

  resources :statuses, only: [:index]

  post "/_chatops/:chatop", controller: "chatops", action: :execute_chatop
  get  "/_chatops", to: "chatops#list"

  post "/api/graphql", to: "graphql#execute"
end
