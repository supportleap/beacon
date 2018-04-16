# frozen_string_literal: true

module Graph
  module Enums
    class StatusLevel < GraphQL::Schema::Enum
      description "The severity level for a status event."

      value "GREEN", "No known issues.", value: "green"
      value "YELLOW", "A minor outage.", value: "yellow"
      value "RED", "A major outage.", value: "red"
    end
  end
end
