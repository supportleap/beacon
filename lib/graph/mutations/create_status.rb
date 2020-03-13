# frozen_string_literal: true

module Graph
  module Mutations
    class CreateStatus < Graph::Mutations::Base
      description "Create a new status event."

      argument :level, Enums::StatusLevel, "The level of this status event.", required: true
      argument :message, String, "The message for this status event.", required: false

      field :status, Objects::Status, "The status event that was created.", null: true
      field :errors, [String], null: false

      def resolve(**inputs)
        result = Statuses::CreateStatus.call(
          level: inputs[:level],
          message: inputs[:message],
        )

        if result.success?
          {
            status: result.status,
            errors: [],
          }
        else
          {
            status: nil,
            errors: result.errors,
          }
        end
      end
    end
  end
end
