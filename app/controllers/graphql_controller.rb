# frozen_string_literal: true

class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:execute]
  before_action :authenticate

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      # current_user: current_user,
    }
    result = Graph::Schema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  def authenticate
    api_key = Beacon.api_token

    if !api_key.present? || api_key.blank?
      raise RuntimeError, "Please set API_KEY in the environment to a randomly generated token."
    end

    authenticate_or_request_with_http_token do |token, opts|
      ActiveSupport::SecurityUtils.secure_compare(token, api_key)
    end
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
