# frozen_string_literal: true

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

  def current_page(page_param = :page)
    if params[page_param].blank? || !params[page_param].respond_to?(:to_i)
      1
    else
      params[page_param].to_i.abs
    end
  end
end
