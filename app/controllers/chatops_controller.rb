# frozen_string_literal: true

class ChatopsController < ApplicationController
  skip_before_action :verify_authenticity_token

  include ::Chatops::Controller

  chatops_namespace :beacon

  chatops_help <<-EOS
:rotating_light: Beacon – Leap's status page.
EOS

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

  chatop :current_status,
  /sup/,
  "sup - See the current status." do
    if status = Status.last
      jsonrpc_success("Latest status: #{status.level.upcase} - #{status.message}")
    else
      jsonrpc_success("No status currently set. Set one with `set <level>`.")
    end
  end
end
