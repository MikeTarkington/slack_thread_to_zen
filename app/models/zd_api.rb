require 'net/http'
require 'uri'
require 'json'

class ZdApi < ApplicationRecord

  def initialize(update_str)
    uri = URI.parse("https://tarktest.zendesk.com/api/v2/tickets/2.json")
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


  # initialize
  #   uri = URI.parse("https://tarktest.zendesk.com/api/v2/tickets/2.json")
  #   request = Net::HTTP::Put.new(uri)
  #   request.basic_auth(ENV['ZD_EMAIL'], ENV['ZD_PASS'])
  #   @request.content_type = "application/json"
  #
  #   req_options = {
  #     use_ssl: uri.scheme == "https",
  #   }
  # end
  #
  # def format_comment(thread)
  #   thread
  # end
  #
  # def update_ticket(request)
  #   request.body = JSON.dump({
  #     "ticket" => {
  #       "comment" => {
  #         "public" => false,
  #         "body" => "#{unformatted_thread.reverse[0][:user]} - #{Time.at(unformatted_thread.reverse[0][:time].to_i)}\n#{unformatted_thread.reverse[0][:body]}",
  #         "author_id" => 494820284
  #       }
  #     }
  #   })
  #
  #   response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  #     http.request(request)
  #   end
  #   p response.code
  #   p response.body
  # end

end
