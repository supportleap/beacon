# frozen_string_literal: true

require "test_helper"

class ChatopsControllerTest < Chatops::Controller::TestCase
  setup do
    chatops_prefix "beacon"
    chatops_auth!
  end

  test "sets a status with default green message" do
    chat "beacon set green", "test-user"

    latest_status = Status.last

    assert_equal "Updated status: GREEN - #{Status::GREEN_MESSAGE}", chatop_response
    assert_equal "green", latest_status.level
    assert_equal Status::GREEN_MESSAGE, latest_status.message
  end

  test "sets a status with default yellow message" do
    chat "beacon set yellow", "test-user"

    latest_status = Status.last

    assert_equal "Updated status: YELLOW - #{Status::YELLOW_MESSAGE}", chatop_response
    assert_equal "yellow", latest_status.level
    assert_equal Status::YELLOW_MESSAGE, latest_status.message
  end

  test "sets a status with default red message" do
    chat "beacon set red", "test-user"

    latest_status = Status.last

    assert_equal "Updated status: RED - #{Status::RED_MESSAGE}", chatop_response
    assert_equal "red", latest_status.level
    assert_equal Status::RED_MESSAGE, latest_status.message
  end

  test "sets a status with custom message" do
    chat "beacon set green We're all green, folks", "test-user"

    latest_status = Status.last

    assert_equal "Updated status: GREEN - We're all green, folks", chatop_response
    assert_equal "green", latest_status.level
    assert_equal "We're all green, folks", latest_status.message
  end

  test "setting a status returns error if message is too long" do
    chat "beacon set yellow #{'a' * 141}", "test-user"

    assert_equal "Something went wrong: Message is too long (maximum is 140 characters)", chatop_error
    assert_empty Status.all
  end

  test "sup returns the latest status" do
    status = create(:status)
    chat "beacon sup", "test-user"

    assert_equal "Latest status: #{status.level.upcase} - #{status.message}", chatop_response
  end

  test "sup returns no status if no status is set" do
    chat "beacon sup", "test-user"

    assert_equal "No status currently set. Set one with `set <level>`.", chatop_response
  end
end
