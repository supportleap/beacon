# frozen_string_literal: true

module Graph
  module Objects
    class Base < GraphQL::Schema::Object
      def global_id_field(field_name)
        field field_name, "ID", null: false, method: :global_relay_id
      end
    end
  end
end
