require 'uri'
require 'net/http'
require 'json'

class SlackApi < ApplicationRecord

  def initialize
  end

  def msg_search(query_term)
    uri = URI("https://slack.com/api/search.messages?token=#{ENV['SLACK_TOKEN']}&query=#{query_term}")
    response = Net::HTTP.get(uri)
    search_resp = JSON.parse(response)
  end

  def channel_hist(channel_id)
    uri = URI("https://slack.com/api/channels.history?token=#{ENV['SLACK_TOKEN']}&channel=#{channel_id}&count=1000")
    response = Net::HTTP.get(uri)
    chan_hist_resp = JSON.parse(response)
  end

  def parse_timestamp(search_resp)
    #get to the permalink and pull out the ts value to be used for finding corersponding matches in the channel hist parser
    timestamp = /(?<=thread_ts=)\d{10}.\d{6}/.match(search_resp['messages']['matches'][0]['permalink'])[0]
  end

  def parse_chan_hist(chan_hist_resp, timestamp)
    #pull the needed values of the json object first finding matches for the thread ts
    #then for each match found, collect the correct pieces of info to be send to zd
    thread_messages = []
    chan_hist_resp['messages'].each do |message|
      if message['thread_ts'] == timestamp then thread_messages << message end
    end
    thread_messages
  end

  def thread_msgs_content(thread_messages)
    thread_msgs_content = []
    formed_msg = {}
    thread_messages.each do |msg|
      formed_msg[:user] = msg['user']
      formed_msg[:body] = msg['text']
      formed_msg[:time] = msg['ts']
      formed_msg
      thread_msgs_content << formed_msg.dup
    end
    thread_msgs_content
  end

  def format_comment(raw_thread)
      comment_str = ""
      msg_str = ""
      uri = []
      response = []
      user = {}
      # Lost free access to ZD account trial so I couldnt' test but it would be
      # more performant and require less calls if the process of adding user names
      # to the msg_str was done with a hash data structure for dictionary lookup on
      # on any id's for which we have already found a name instead making a new
      # call for each id. threads typically have a few people repeatedly sending msgs
      raw_thread.each do |msg|
        uri = URI("https://slack.com/api/users.info?token=#{ENV['SLACK_TOKEN']}&user=#{msg[:user]}")
        response = Net::HTTP.get(uri)
        user = JSON.parse(response)
        msg_str += user['user']['name']
        msg_str += "  -  #{Time.at(msg[:time].to_i)}\n"
        msg_str += "-> #{msg[:body]}\n"
        comment_str.prepend(msg_str)
        msg_str = ""
      end
      # would have been nice to get the url of the parent message but slack wasn't
      # making it easy so I just used the url for the "breacrumb" message
    comment_str #.prepend("Slack Thead URL: #{parent_msg_url}\n")
  end

end
