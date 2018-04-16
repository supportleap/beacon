# frozen_string_literal: true

class DashboardController < ApplicationController
  INDEX_STATUS_COUNT = 5

  IndexQuery = parse_query <<-'GRAPHQL'
    query($first: Int!) {
      ...Views::Dashboard::Index::Statuses
    }
  GRAPHQL

  def index
    data = execute_query(IndexQuery, variables: { first: INDEX_STATUS_COUNT })
    render "dashboard/index", locals: { data: data }
  end
end
