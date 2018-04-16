# frozen_string_literal: true

module Graph
  class Schema < GraphQL::Schema
    GraphQL::Relay::ConnectionType.default_nodes_field = true

    mutation(Mutations::Root)
    query(Queries::Root)

    def self.id_from_object(object, _, _)
      object.global_relay_id
    end

    def self.object_from_id(id, context)
      type_name, model_id = GraphQL::Schema::UniqueWithinType.decode(id)
      klass = "::#{type_name}".constantize

      klass.find(model_id)
    end

    def self.resolve_type(type, object, context)
      type_name = object.class.try(:graphql_type_name) || object.class.name.demodulize
      self.types[type_name]
    end
  end
end
