# frozen_string_literal: true

require "test_helper"

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  setup do
    Beacon.stubs(:api_token).returns("abc123")
  end

  test "rejects access if api token does not match" do
    post "/api/graphql", headers: { "Authorization" => 'Token token="hewwo"' }

    assert_response :unauthorized
  end

  test "accepts request if api token matches" do
    post "/api/graphql", headers: { "Authorization" => 'Token token="abc123"' }

    assert_response :success
  end
end
