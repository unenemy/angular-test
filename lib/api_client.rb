require 'faraday'
require 'faraday_middleware'

class ApiClient

  QUERIES = %w(years makes models options vehicle_fitments)

  def initialize(ip)
    @ip = Base64.urlsafe_encode64(ip)
    @connection = begin
      host_url = "http://api.tiresync.com:80"
      api_v = "v1"
      api_db = "oe"

      faraday_options = {
          :url     => [host_url, api_v, api_db].join("/"),
          :headers => {
              :accept     => 'application/json',
              :user_agent => 'dotpromo platform'
          },
          :request => {
              :timeout      => 60,
              :open_timeout => 60
          }
      }
      Faraday::Connection.new(faraday_options) do |conn|
        conn.request :url_encoded
        conn.adapter :net_http
        conn.response :json, :content_type => /\bjson$/
      end
    end
  end

  def ip
    @ip
  end

  def key
    "1111-1111-1111-1111"
  end

  QUERIES.each do |query|
    define_method "get_#{query}" do |*args|
      res = @connection.get(build_request(query, args)).body["items"]
      query == "vehicle_fitments" ?  res : res.map{|item| {name: item} }
    end
  end

  def build_request(query, params)
    [[query, key, ip] + params.map{ |param| Base64.urlsafe_encode64(param)}].join("/")
  end
end