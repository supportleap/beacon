# frozen_string_literal: true

require "test_helper"

class StatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @green_status = create(:status, level: :green)
    @yellow_status = create(:status, level: :yellow)
    @red_status = create(:status, level: :red)
  end

  test "#index lists current statuses" do
    get "/statuses"

    assert_response :success
    assert_select ".status-history .Box", 3
    assert_select ".status-history .Box h3", /#{@red_status.message}/
    assert_select ".status-history .Box h3", /#{@yellow_status.message}/
    assert_select ".status-history .Box h3", /#{@green_status.message}/
  end

  test "#index shows next button if has next page" do
    (StatusesController::PER_PAGE).times { create(:status) }

    get "/statuses"

    assert_response :success
    assert_select ".status-history .paginate-container a", "Next page"
  end

  test "#index shows message if no statuses" do
    Status.destroy_all
    assert_empty Status.all

    get "/statuses"

    assert_response :success
    assert_select ".status-history p", "Couldn't find any status events."
  end
end
