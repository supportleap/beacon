# frozen_string_literal: true

require 'test_helper'

class Statuses::CreateStatusTest < ActiveSupport::TestCase
  test "creates a status with default message" do
    assert_empty Status.all

    result = Statuses::CreateStatus.call(level: "green")

    assert_predicate result, :success?
    assert_empty result.errors
    assert_equal Status.default_message_for("green"), result.status.message
    assert_equal [result.status], Status.all
  end

  test "creates a status with custom message" do
    assert_empty Status.all

    result = Statuses::CreateStatus.call(
      level: "green",
      message: "Hack the planet",
    )

    assert_predicate result, :success?
    assert_empty result.errors
    assert_equal "Hack the planet", result.status.message
    assert_equal [result.status], Status.all
  end

  test "returns error for invalid level value" do
    assert_empty Status.all

    result = Statuses::CreateStatus.call(
      level: "orisa",
      message: "Hack the planet",
    )

    refute_predicate result, :success?
    assert_equal ["'orisa' is not a valid level"], result.errors
    assert_empty Status.all
  end

  test "returns error for message over limit" do
    assert_empty Status.all

    message = "a" * 141

    result = Statuses::CreateStatus.call(
      level: "green",
      message: message,
    )

    refute_predicate result, :success?
    assert_equal ["Message is too long (maximum is 140 characters)"], result.errors
    assert_empty Status.all
  end
end
