# frozen_string_literal: true

module Statuses
  class CreateStatus

    # inputs - A Hash of attributes to create a status.
    # inputs[:level] - A String that is a `level` enum value for a Status.
    # inputs[:message] - (optional) A String message to use for the status.
    def self.call(inputs)
      new(inputs).call
    end

    def initialize(level:, message: nil)
      @level   = level
      @message = message
    end

    def call
      status_message = if message.blank?
        Status.default_message_for(level)
      else
        message
      end

      status = Status.new(
        level: level,
        message: status_message,
      )

      if status.save
        Result.success(status: status)
      else
        Result.failure(errors: status.errors.full_messages)
      end
    rescue ArgumentError => error
      Result.failure(errors: [error.message])
    end

    private

    attr_reader :level, :message

    class Result
      attr_reader :status, :success, :errors
      alias_method :success?, :success

      # status - The Status that is being created.
      # success - A Boolean indicating if creating the status was successful.
      # errors - An Array of any errors that occured when creating the listing.
      def initialize(status:, success:, errors:)
        @status  = status
        @success = success
        @errors  = errors
      end

      def self.success(status:)
        new(
          status: status,
          success: true,
          errors: [],
        )
      end

      def self.failure(errors:)
        new(
          status: nil,
          success: false,
          errors: errors,
        )
      end
    end
  end
end
