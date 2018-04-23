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
    p @search_resp = JSON.parse(response)
  end

  def channel_hist(channel_id)
    uri = URI("https://slack.com/api/channels.history?token=#{ENV['SLACK_TOKEN']}&channel=#{channel_id}&count=1000")
    response = Net::HTTP.get(uri)
    p @chan_hist_resp = JSON.parse(response)
  end

end


# p params =  {
#             endpoint: 'https://slack.com/api/search.messages',
#             slack_token: 'xoxp-300848166629-300079888624-301797961287-babcd37e66002c8202cd96bc301f0e16',
#             query: 'everyone',
#             pretty: '1'
#           }
# p uri = URI.encode_www_form(params)
#
# p response = Net::HTTP::Get.new(uri)
# p response.read_body
# # p uri.query = URI.encode_www_form(params)

#sample response from search call:
=begin
{"ok"=>true, "query"=>"890", "messages"=>{"total"=>1, "pagination"=>{"total_count"=>1, "page"=>1, "per_page"=>20, "page_count"=>1, "first"=>1, "last"=>1}, "paging"=>{"count"=>20, "total"=>1, "page"=>1, "pages"=>1}, "matches"=>[{"previous"=>{"type"=>"message", "user"=>"U8U2BS4JC", "username"=>"michael.tarkington", "ts"=>"1523167540.000017", "text"=>"zd 678", "iid"=>"948fa45b-d1e0-428d-94c1-bb20819a6b07", "permalink"=>"https://ddtest-workspace.slack.com/archives/C8VH6NR2A/p1523167540000017?thread_ts=1523098535.000028"}, "previous_2"=>{"type"=>"message", "user"=>"U8U2BS4JC", "username"=>"michael.tarkington", "ts"=>"1523098535.000028", "text"=>"345", "iid"=>"1fbf8083-491e-4c8c-bb8e-2ce26faf1aca", "permalink"=>"https://ddtest-workspace.slack.com/archives/C8VH6NR2A/p1523098535000028?thread_ts=1523098535.000028"}, "next"=>{"type"=>"message", "user"=>"U8U2BS4JC", "username"=>"michael.tarkington", "ts"=>"1523167920.000054", "text"=>"zd stuff", "iid"=>"82078702-1362-44f8-901e-a7beee4ba810", "permalink"=>"https://ddtest-workspace.slack.com/archives/C8VH6NR2A/p1523167920000054?thread_ts=1523098535.000028"}, "next_2"=>{"type"=>"message", "user"=>"U8U2BS4JC", "username"=>"michael.tarkington", "ts"=>"1523168134.000077", "text"=>"zd another", "iid"=>"2cfad9cf-3eaa-4b95-862d-703e7c2549cf", "permalink"=>"https://ddtest-workspace.slack.com/archives/C8VH6NR2A/p1523168134000077?thread_ts=1523098535.000028"}, "type"=>"message", "user"=>"U8U2BS4JC", "username"=>"michael.tarkington", "ts"=>"1523167752.000021", "text"=>"zd 890", "iid"=>"87e00dc0-baa7-4a13-b7d9-fe597c2cee4e", "permalink"=>"https://ddtest-workspace.slack.com/archives/C8VH6NR2A/p1523167752000021?thread_ts=1523098535.000028", "team"=>"T8UQY4WJH", "channel"=>{"id"=>"C8VH6NR2A", "is_channel"=>true, "is_group"=>false, "is_im"=>false, "name"=>"general", "is_shared"=>false, "is_org_shared"=>false, "is_ext_shared"=>false, "is_private"=>false, "is_mpim"=>false, "pending_shared"=>[], "is_pending_ext_shared"=>false}}], "refinements"=>[]}}
=end

#sample response from channel_hist call:
=begin
{"ok"=>true, "messages"=>[{"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"zd another", "thread_ts"=>"1523098535.000028", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1523168134.000077"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"zd stuff", "thread_ts"=>"1523098535.000028", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1523167920.000054"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"zd 890", "thread_ts"=>"1523098535.000028", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1523167752.000021"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"zd 678", "thread_ts"=>"1523098535.000028", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1523167540.000017"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"345", "thread_ts"=>"1523098535.000028", "reply_count"=>4, "replies"=>[{"user"=>"U8U2BS4JC", "ts"=>"1523167540.000017"}, {"user"=>"U8U2BS4JC", "ts"=>"1523167752.000021"}, {"user"=>"U8U2BS4JC", "ts"=>"1523167920.000054"}, {"user"=>"U8U2BS4JC", "ts"=>"1523168134.000077"}], "subscribed"=>true, "last_read"=>"1523168134.000077", "unread_count"=>0, "ts"=>"1523098535.000028"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"and finding out if the thread works on it as well", "thread_ts"=>"1522039112.000073", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1522039130.000026"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"starting a second conversation", "thread_ts"=>"1522039112.000073", "reply_count"=>1, "replies"=>[{"user"=>"U8U2BS4JC", "ts"=>"1522039130.000026"}], "subscribed"=>true, "last_read"=>"1522039130.000026", "unread_count"=>0, "ts"=>"1522039112.000073"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"aaaaand here’s a thread", "thread_ts"=>"1516264522.000504", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1516266059.000223"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"here’s a test message to find in the api test", "thread_ts"=>"1516264522.000504", "reply_count"=>1, "replies"=>[{"user"=>"U8U2BS4JC", "ts"=>"1516266059.000223"}], "subscribed"=>true, "last_read"=>"1516266059.000223", "unread_count"=>0, "ts"=>"1516264522.000504"}, {"user"=>"U8U2BS4JC", "text"=>"<@U8U2BS4JC> has joined the channel", "type"=>"message", "subtype"=>"channel_join", "ts"=>"1516262808.000154"}], "has_more"=>false}
=end

def parse_timestamp(@search_resp)
  #get to the permalink and pull out the ts value to be used for finding corersponding matches in the channel hist parser

  p @search_resp['messages']['matches'][0]
end

def parse_chan_hist(@chan_hist_resp, @search_resp)
  #pull the needed values of the json object first finding matches for the thread ts
  #then for each match found, collect the correct pieces of info to be send to zd

end
