# frozen_string_literal: true

module Graph
  module Helpers
    module GlobalRelayIdentification
      def global_relay_id
        GraphQL::Schema::UniqueWithinType.encode(self.class.name, id)
      end
    end
  end
end
