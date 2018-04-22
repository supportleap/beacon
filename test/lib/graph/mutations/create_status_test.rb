# frozen_string_literal: true

require 'test_helper'

class Graph::Mutations::CreateStatusTest < ActiveSupport::TestCase

  test "creates a status event" do
    query = <<-'GRAPHQL'
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

    message = "All is well, folks!"

    results = execute_query(query, variables: { level: "GREEN", message: message })
    assert_equal "GREEN", results["data"]["createStatus"]["status"]["level"]
    assert_equal message, results["data"]["createStatus"]["status"]["message"]
    assert_empty results["data"]["createStatus"]["errors"]
  end

  test "creates a status event with a default message" do
    query = <<-'GRAPHQL'
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

    results = execute_query(query, variables: { level: "GREEN", message: nil })
    assert_equal "GREEN", results["data"]["createStatus"]["status"]["level"]
    assert_equal Status::GREEN_MESSAGE, results["data"]["createStatus"]["status"]["message"]
    assert_empty results["data"]["createStatus"]["errors"]
  end

  test "creates a status event with different status level" do
    query = <<-'GRAPHQL'
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

    results = execute_query(query, variables: { level: "RED", message: nil })
    assert_equal "RED", results["data"]["createStatus"]["status"]["level"]
    assert_equal Status::RED_MESSAGE, results["data"]["createStatus"]["status"]["message"]
    assert_empty results["data"]["createStatus"]["errors"]
  end

  test "doesn't create a status and displays errors if message is too long" do
    query = <<-'GRAPHQL'
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

    results = execute_query(query, variables: { level: "YELLOW", message: "a" * 141 })
    assert_nil results["data"]["status"]
    assert_equal ["Message is too long (maximum is 140 characters)"], results["data"]["createStatus"]["errors"]
    assert_equal 0, Status.all.count
  end
end
