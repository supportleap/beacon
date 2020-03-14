# frozen_string_literal: true

class StatusesController < ApplicationController
  PER_PAGE = 35

  def index
    statuses = Status.paginate(
      page: current_page,
      per_page: PER_PAGE,
    ).order('id DESC')

    render "statuses/index", locals: { statuses: statuses }
  end
end
