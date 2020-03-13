# frozen_string_literal: true

require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test ".default_message_for returns message for level" do
    assert_equal "Everything operating normally.", Status.default_message_for("green")
    assert_equal "We're investigating increased error rates.", Status.default_message_for("yellow")
    assert_equal "We're investigating service unavailability.", Status.default_message_for("red")
  end

  test ".default_message_for raises if level is invalid" do
    assert_raises(ArgumentError) { Status.default_message_for("hewwo") }
  end
end
