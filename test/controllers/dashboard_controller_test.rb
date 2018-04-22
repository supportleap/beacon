# frozen_string_literal: true

require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @green_status = create(:status, level: :green)
    @yellow_status = create(:status, level: :yellow)
  end

  test "#index displays latest status" do
    get "/"

    assert_response :success
    assert_select ".big-status h1", @yellow_status.message
  end

  test "#index lists recent status events, not including the latest" do
    get "/"

    assert_response :success
    assert_select ".status-history .Box", 1
    assert_select ".status-history .Box h3", /#{@green_status.message}/
  end

  test "#index works if no status events" do
    Status.destroy_all
    assert_empty Status.all

    get "/"

    assert_response :success
    assert_select ".big-status h1", "Current status unknown."
    assert_select ".status-history p", "No status events yet. Hooray uptime!"
  end

  test "#index displays no status history if only one status event" do
    Status.destroy_all
    assert_empty Status.all

    status = create(:status)

    get "/"

    assert_response :success
    assert_select ".big-status h1", status.message
    assert_select ".status-history p", "No status events yet. Hooray uptime!"
  end
end
