# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_page(page_param = :page)
    if params[page_param].blank? || !params[page_param].respond_to?(:to_i)
      1
    else
      params[page_param].to_i.abs
    end
  end
end
