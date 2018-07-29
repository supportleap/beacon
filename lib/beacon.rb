# frozen_string_literal: true

module Beacon
  class << self
    # The token used for authenticating to the GraphQL API.
    #
    # Returns a String.
    def api_token
      @api_token ||= ENV["API_KEY"]
    end
  end
end
