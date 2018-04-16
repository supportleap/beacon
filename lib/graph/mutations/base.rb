# frozen_string_literal: true

module Graph
  module Mutations
    class Base < GraphQL::Schema::RelayClassicMutation
      object_class Graph::Objects::Base
    end
  end
end
