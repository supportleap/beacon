# frozen_string_literal: true

module Graph
  class Schema < GraphQL::Schema
    GraphQL::Relay::ConnectionType.default_nodes_field = true

    mutation(Objects::Mutation)
    query(Objects::Query)

    def self.id_from_object(object, _, _)
      object.global_relay_id
    end

    def self.object_from_id(id, context)
      type_name, model_id = GraphQL::Schema::UniqueWithinType.decode(id)

      unless Graph::Schema.types.key?(type_name)
        return raise GraphQL::ExecutionError.new("Could not resolve to a node with the global id of '#{id}'.")
      end

      klass = "::#{type_name}".constantize

      if obj = klass.find_by(id: model_id)
        obj
      else
        raise GraphQL::ExecutionError.new("Could not resolve to a node with the global id of '#{id}'.")
      end
    end

    def self.resolve_type(type, object, context)
      type_name = object.class.try(:graphql_type_name) || object.class.name.demodulize
      self.types[type_name]
    end
  end
end
