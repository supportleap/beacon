# frozen_string_literal: true

module Beacon
  # The token used for authenticating to the GraphQL API.
  #
  # Returns a String.
  def self.api_token
    ENV["API_KEY"]
  end
end
