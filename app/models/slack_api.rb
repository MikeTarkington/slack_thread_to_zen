class SlackApi < ApplicationRecord

  require 'uri'
  require 'net/http'

  url = URI("https://slack.com/api/search.messages?token=#{ENV['SLACK_TOKEN']}&query=everyone&pretty=1")

  http = Net::HTTP.new(url.host, url.port)

  request = Net::HTTP::Get.new(url)
  request["Cache-Control"] = 'no-cache'
  request["Postman-Token"] = ENV['POSTMAN_TOKEN']

  response = http.request(request)

  def msg_search
    response.read_body
  end

end
