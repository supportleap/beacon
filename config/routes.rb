Rails.application.routes.draw do
  root "dashboard#index"
  post "/api/graphql", to: "graphql#execute"
  get "/statuses", to: "statuses#index"
end
