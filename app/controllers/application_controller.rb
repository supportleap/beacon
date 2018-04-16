class ApplicationController < ActionController::Base
  def self.parse_query(query)
    Graph.client.parse(query)
  end

  def execute_query(query, variables: {})
    variables = variables.map { |k, v| [k.to_s, v] }.to_h

    response = Graph.client.query(query,
      variables: variables,
      context: {})

    response.data
  end
  helper_method :execute_query
end
