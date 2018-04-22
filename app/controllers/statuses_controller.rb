# frozen_string_literal: true

class StatusesController < ApplicationController
  PER_PAGE = 35

  IndexQuery = parse_query <<-'GRAPHQL'
    query($first: Int!, $after: String) {
      ...Views::Statuses::Index::Statuses
    }
  GRAPHQL

  def index
    data = execute_query(IndexQuery, variables: { first: PER_PAGE, after: params[:after] })
    render "statuses/index", locals: { data: data }
  end
end
