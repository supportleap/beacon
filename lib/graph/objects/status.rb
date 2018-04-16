# frozen_string_literal: true

module Graph
  module Objects
    class Status < Graph::Objects::Base
      description "A status event."

      implements GraphQL::Relay::Node.interface

      global_id_field :id

      field :level, Enums::StatusLevel, "The severity level of this status event.", null: false
      field :message, String, "The message associated with this status event.", null: false
      field :created_at, Scalars::DateTime, "The time this status was created at.", null: true
    end
  end
end
