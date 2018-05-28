require 'net/http'
require 'uri'
require 'json'

class ZdApi < ApplicationRecord

  def initialize(update_str, ticket_num)
    uri = URI.parse("https://tarktest.zendesk.com/api/v2/tickets/#{ticket_num}.json")
    request = Net::HTTP::Put.new(uri)
    request.basic_auth(ENV['ZD_EMAIL'], ENV['ZD_PASS'])
    request.content_type = "application/json"
    request.body = JSON.dump({
      "ticket" => {
        "comment" => {
          "public" => false,
          "body" => "#{update_str}",
          "author_id" => 494820284
        }
      }
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end

end
