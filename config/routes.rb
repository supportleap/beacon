Rails.application.routes.draw do
  root "dashboard#index"

  post "/_chatops/:chatop", controller: "chatops", action: :execute_chatop
  get  "/_chatops" => "chatops#list"

  post "/api/graphql", to: "graphql#execute"

  get "/statuses", to: "statuses#index"
end
