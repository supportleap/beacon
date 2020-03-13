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
    result = Statuses::CreateStatus.call(
      level: jsonrpc_params[:level],
      message: jsonrpc_params[:message],
    )

    if result.success?
      jsonrpc_success("Updated status: #{result.status.level.upcase} - #{result.status.message}")
    else
      jsonrpc_failure("Something went wrong: #{result.errors.join(", ")}")
    end
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
