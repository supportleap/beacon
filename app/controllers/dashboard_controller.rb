# frozen_string_literal: true

class DashboardController < ApplicationController
  INDEX_STATUS_LIMIT = 5

  def index
    all_statuses = Status.order("id DESC").limit(INDEX_STATUS_LIMIT + 1)
    latest_status = all_statuses.first
    statuses = all_statuses.drop(1)

    render "dashboard/index", locals: {
      latest_status: latest_status,
      statuses: statuses,
    }
  end
end
