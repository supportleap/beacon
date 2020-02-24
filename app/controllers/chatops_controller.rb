class ChatopsController < ApplicationController
  skip_before_action :verify_authenticity_token

  include ::Chatops::Controller

  chatops_namespace :beacon

  chatops_help <<-EOS
:rotating_light: Beacon – Leap's status page.
EOS

  CreateStatusQuery = parse_query <<-'GRAPHQL'
    mutation($level: StatusLevel!, $message: String) {
      createStatus(input: { level: $level, message: $message }) {
        status {
          level
          message
        }
        errors
      }
    }
  GRAPHQL

  chatop :create_status,
  /set (?<level>red|yellow|green)(?: (?<message>(.*)))?/i,
  "set <level> <message> - Set the current status. Message is optional." do
    level = jsonrpc_params[:level].upcase
    message = jsonrpc_params[:message].blank? ? nil : jsonrpc_params[:message]

    data = execute_query(CreateStatusQuery, variables: { level: level, message: message })

    status_result = data.create_status

    if data.errors.any?
      return jsonrpc_failure("Something went wrong: #{data.errors.messages.values.join(", ")}")
    end

    if status_result.errors.any?
      return jsonrpc_failure("Something went wrong: #{status_result.errors.join(", ")}")
    end

    jsonrpc_success("Updated status: #{status_result.status.level} - #{status_result.status.message}")
  end

  CurrentStatusQuery = parse_query <<-'GRAPHQL'
    query {
      latestStatus {
        level
        message
      }
    }
  GRAPHQL

  chatop :current_status,
  /sup/,
  "sup - See the current status." do
    data = execute_query(CurrentStatusQuery)

    if data.errors.any?
      return jsonrpc_failure("Something went wrong: #{data.errors.messages.values.join(", ")}")
    end

    if data.latest_status
      jsonrpc_success("Latest status: #{data.latest_status.level} - #{data.latest_status.message}")
    else
      jsonrpc_success("No status currently set. Set one with `set <level>`.")
    end
  end
end
