module Graph
  module Objects
    class Mutation < Graph::Objects::Base
      description "The root query for mutations."
      field :create_status, mutation: Mutations::CreateStatus
    end
  end
end
