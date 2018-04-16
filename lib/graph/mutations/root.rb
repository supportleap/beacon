# frozen_string_literal: true

module Graph
  module Mutations
    class Root < Graph::Objects::Base
      graphql_name "Mutation"
      description "The root query for mutations."

      field :createStatus, mutation: CreateStatus
    end
  end
end
