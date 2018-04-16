# frozen_string_literal: true

module Graph
  def self.client
    @client ||= GraphQL::Client.new(schema: Schema, execute: Schema)
  end

  def self.execute(query, context: {}, variables: {})
    Schema.execute(query, context: context, variables: variables)
  end
end
