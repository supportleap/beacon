# frozen_string_literal: true

require 'test_helper'

class Graph::Objects::StatusTest < ActiveSupport::TestCase
  setup do
    @status = create(:status, message: "We've fixed the problem.")
  end

  test "displays alert information" do
    query = <<-'GRAPHQL'
      query($id: ID!) {
        node(id: $id) {
          ... on Status {
            level
            message
            createdAt
          }
        }
      }
    GRAPHQL

    results = execute_query(query, variables: { id: @status.global_relay_id })
    assert_equal @status.level.upcase, results["data"]["node"]["level"]
    assert_equal @status.message, results["data"]["node"]["message"]
    assert_equal @status.created_at.utc.iso8601, results["data"]["node"]["createdAt"]
  end
end
