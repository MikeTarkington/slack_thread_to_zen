require 'test_helper'

class MessageControllerTest < ActionDispatch::IntegrationTest
  test "should get slash_command" do
    get message_slash_command_url
    assert_response :success
  end

  test "should get slack_thread" do
    get message_slack_thread_url
    assert_response :success
  end

  test "should get zd_comment" do
    get message_zd_comment_url
    assert_response :success
  end

end
