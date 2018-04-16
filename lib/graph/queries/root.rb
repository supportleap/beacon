# frozen_string_literal: true

module Graph
  module Queries
    # TODO: Use new class-based object
    Root = GraphQL::ObjectType.define do
      name "Root"

      field :node, GraphQL::Relay::Node.field

      field :latestStatus, Objects::Status do
        description "The latest status event."

        resolve -> (object, arguments, context) {
          Status.last
        }
      end

      connection :statuses, Objects::Status.connection_type do
        description "All status events."
        argument :includeLatest, types.Boolean, "Should the list include the latest status event?"

        resolve -> (object, arguments, context) {
          scope = Status.all.order("id DESC")

          if arguments[:includeLatest] == false
            scope = scope.offset(1)
          end

          scope
        }
      end
    end
  end
end
