# frozen_string_literal: true

class StatusesController < ApplicationController
  IndexQuery = parse_query <<-'GRAPHQL'
    query($first: Int!, $after: String) {
      ...Views::Statuses::Index::Statuses
    }
  GRAPHQL

  def index
    data = execute_query(IndexQuery, variables: { first: 35, after: params[:after] })
    render "statuses/index", locals: { data: data }
  end
end
