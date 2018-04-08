require 'uri'
require 'net/http'

class SlackApi < ApplicationRecord

  def initialize
    p '*' * 80
    p url = URI("https://slack.com/api/search.messages?token=#{ENV['SLACK_TOKEN']}&query=everyone&pretty=1")

    p http = Net::HTTP.new(url.host, url.port)

    p request = Net::HTTP::Get.new(url)
    request["Cache-Control"] = 'no-cache'
    request["Postman-Token"] = ENV['POSTMAN_TOKEN']
    p request

    p @response = http.request(request)
  end

  def msg_search
    p @response.read_body
  end

end
