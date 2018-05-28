class MessageController < ApplicationController

  def slash_command
    slack = SlackApi.new
    msg = slack.msg_search(params['text'])
    chan_hist_resp = slack.channel_hist(params['channel_id'])
    timestamp = slack.parse_timestamp(msg)
    thread_messages = slack.parse_chan_hist(chan_hist_resp, timestamp)
    thread_msgs_content = slack.thread_msgs_content(thread_messages)
    breadcrumb_permalink = msg['messages']['matches'][0]['permalink']
    comment_str = slack.format_comment(thread_msgs_content)
    comment_str.prepend("#{breadcrumb_permalink}\n")
    ZdApi.new(comment_str, params['text'])
  end

end
