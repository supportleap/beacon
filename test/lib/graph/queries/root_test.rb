# frozen_string_literal: true

require 'test_helper'

class Graph::Queries::RootTest < ActiveSupport::TestCase
  setup do
    @green_status = create(:status)
    @yellow_status = create(:yellow_status)
    @red_status = create(:red_status)
  end

  test "displays the latest status event" do
    query = <<-'GRAPHQL'
      query {
        latestStatus {
          id
          level
          message
          createdAt
        }
      }
    GRAPHQL

    results = execute_query(query)
    assert_equal @red_status.global_relay_id, results["data"]["latestStatus"]["id"]
    assert_equal @red_status.level.upcase, results["data"]["latestStatus"]["level"]
    assert_equal @red_status.message, results["data"]["latestStatus"]["message"]
    assert_equal @red_status.created_at.utc.iso8601, results["data"]["latestStatus"]["createdAt"]
  end

  test "displays all status events" do
    query = <<-'GRAPHQL'
      query {
        statuses(first: 10) {
          nodes {
            id
            level
            message
            createdAt
          }
        }
      }
    GRAPHQL

    results = execute_query(query)
    statuses = results["data"]["statuses"]["nodes"]
    assert_equal 3, statuses.count
    assert_equal @red_status.global_relay_id, statuses.first["id"]
    assert_equal @red_status.level.upcase, statuses.first["level"]
    assert_equal @red_status.message, statuses.first["message"]
    assert_equal @red_status.created_at.utc.iso8601, statuses.first["createdAt"]
    assert_equal @yellow_status.global_relay_id, statuses.second["id"]
    assert_equal @yellow_status.level.upcase, statuses.second["level"]
    assert_equal @yellow_status.message, statuses.second["message"]
    assert_equal @yellow_status.created_at.utc.iso8601, statuses.second["createdAt"]
    assert_equal @green_status.global_relay_id, statuses.third["id"]
    assert_equal @green_status.level.upcase, statuses.third["level"]
    assert_equal @green_status.message, statuses.third["message"]
    assert_equal @green_status.created_at.utc.iso8601, statuses.third["createdAt"]
  end

  test "displays all status events but excludes latest event" do
    query = <<-'GRAPHQL'
      query {
        statuses(first: 10, includeLatest: false) {
          nodes {
            id
            level
            message
            createdAt
          }
        }
      }
    GRAPHQL

    results = execute_query(query)
    statuses = results["data"]["statuses"]["nodes"]
    assert_equal 2, statuses.count
    assert_equal @yellow_status.global_relay_id, statuses.first["id"]
    assert_equal @yellow_status.level.upcase, statuses.first["level"]
    assert_equal @yellow_status.message, statuses.first["message"]
    assert_equal @yellow_status.created_at.utc.iso8601, statuses.first["createdAt"]
    assert_equal @green_status.global_relay_id, statuses.second["id"]
    assert_equal @green_status.level.upcase, statuses.second["level"]
    assert_equal @green_status.message, statuses.second["message"]
    assert_equal @green_status.created_at.utc.iso8601, statuses.second["createdAt"]
  end
end
