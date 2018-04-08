class MessageController < ApplicationController

  #receive the slash command with the zd ticket number
  #parse the params
  #use the parsed params for a Slack search api call to find the channel/thread in question:
    #https://api.slack.com/methods/search.messages
    #parse the permalink attribute url for the thread_ts value
  #make a channel history call using the channel id from the search or slash command params
    #collect 1000 messanges from the channel
    #consider using 'oldest' option in the call to only call things as old as the
      #search result time stamp minus a bit of time
  #search the history for all messages with the thread_ts
  #parse and format the results for submission to zd
    #order the messages properly
    #include the permalink for the main message

  #send zd Call
  #post private temporary notice to user in slack if command process fails
  #post success message if successful

  def slash_command
    # p params
    p SlackApi.msg_search
  end

  def slack_thread
  end

  def zd_comment
  end
end
