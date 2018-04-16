# frozen_string_literal: true

class Status < ApplicationRecord
  include Graph::Helpers::GlobalRelayIdentification
  enum level: [:green, :yellow, :red]
  validates :level, :message, presence: true
  validates :message, length: { maximum: 140 }

  # The default messages for status events.
  GREEN_MESSAGE = "Everything operating normally."
  YELLOW_MESSAGE = "We're investigating increased error rates."
  RED_MESSAGE = "We're investigating service unavailability."

  # Public: Get the default status level for a message.
  #
  # level - a String value defined in the `level` enum.
  #
  # Returns a String.
  def self.default_message_for(level)
    case level
    when "green"
      GREEN_MESSAGE
    when "yellow"
      YELLOW_MESSAGE
    when "red"
      RED_MESSAGE
    else
      raise ArgumentError, "Invalid level value: #{level}"
    end
  end
end
