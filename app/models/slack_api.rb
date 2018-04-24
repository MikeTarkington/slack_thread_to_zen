require 'uri'
require 'net/http'
require 'json'

class SlackApi < ApplicationRecord

  def initialize
#
#     p params =  {
#                 slack_token: ENV['SLACK_TOKEN'],
#                 query: 'everyone',
#                 pretty: '1'
#               }
#
#     p '*' * 80
#     # p url = URI.encode_www_form("https://slack.com/api/search.messages?token=#{ENV['SLACK_TOKEN']}&query=everyone&pretty=1")
#     p url = URI('https://slack.com/api/search.messages').encode_www_form(params)
#
#
#     p http = Net::HTTP.new(url.host, url.port)
#
#     p request = Net::HTTP::Get.new(url)
#     request["Cache-Control"] = 'no-cache'
#     request["Postman-Token"] = ENV['POSTMAN_TOKEN']
#     p request
#
#     p @response = http.request(request)
  end
#
  def msg_search(query_term)
    uri = URI("https://slack.com/api/search.messages?token=#{ENV['SLACK_TOKEN']}&query=#{query_term}")
    response = Net::HTTP.get(uri)
    p search_resp = JSON.parse(response)
  end

  def channel_hist(channel_id)
    uri = URI("https://slack.com/api/channels.history?token=#{ENV['SLACK_TOKEN']}&channel=#{channel_id}&count=1000")
    response = Net::HTTP.get(uri)
    p chan_hist_resp = JSON.parse(response)
  end

  def parse_timestamp(search_resp)
    #get to the permalink and pull out the ts value to be used for finding corersponding matches in the channel hist parser
    p timestamp = /(?<=thread_ts=)\d{10}.\d{6}/.match(search_resp['messages']['matches'][0]['permalink'])[0]
  end

  def parse_chan_hist(chan_hist_resp, timestamp)
    #pull the needed values of the json object first finding matches for the thread ts
    #then for each match found, collect the correct pieces of info to be send to zd
    thread_messages = []
    chan_hist_resp['messages'].each do |message|
      if message['thread_ts'] == timestamp then thread_messages << message end
    end
    p thread_messages
  end

  def thread_msgs_content(thread_messages)
    thread_msgs_content = []
    formed_msg = {}
    thread_messages.each do |msg|
      formed_msg[:user] = msg['user']
      formed_msg[:body] = msg['text']
      formed_msg[:time] = msg['ts']
      p '-' * 80
      p formed_msg
      p thread_msgs_content << formed_msg
    end
    p '*' * 80
    p thread_msgs_content
  end

end
