# frozen_string_literal: true

module Graph
  module Scalars
    class DateTime < Graph::Scalars::Base
      description "An ISO-8601 encoded UTC date string."

      def self.coerce_input(value, context)
        begin
          Time.iso8601(value)
        rescue ArgumentError, ::TypeError
        end
      end

      def self.coerce_result(value, context)
        return unless value
        value.utc.iso8601
      end
    end
  end
end
