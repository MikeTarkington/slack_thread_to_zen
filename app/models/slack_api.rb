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
#   end
#
  def msg_search(query_term)
    uri = URI("https://slack.com/api/search.messages?token=#{ENV['SLACK_TOKEN']}&query=#{query_term}&pretty=1")
    response = Net::HTTP.get(uri)
    p response = JSON.parse(response)
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
