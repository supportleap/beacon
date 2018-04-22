module Graph
  module Objects
    class Query < Graph::Objects::Base
      description "The query root for Supportress."

      field :node, field: GraphQL::Relay::Node.field

      field :latest_status, Objects::Status, "The latest status event.", null: true

      def latest_status
        ::Status.last
      end

      field :statuses, Objects::Status.connection_type, "All status events.", null: false, connection: true do
        argument :include_latest, Boolean, "Specifies if the latest status event should be included.", required: false
      end

      def statuses(**arguments)
        scope = ::Status.all.order("id DESC")

        if arguments[:include_latest] == false
          scope = scope.offset(1)
        end

        scope
      end
    end
  end
end
