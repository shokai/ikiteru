#!/usr/bin/evn ruby
require 'rubygems'
require 'eventmachine'
require 'evma_httpserver'

port = ARGV.first ? ARGV.shift.to_i : 8080

class TestHttpServer < EM::Connection
  include EM::HttpServer

  def process_http_request
    res = EM::DelegatedHttpResponse.new(self)
    puts "* http #{@http_request_method} #{@http_path_info} #{@http_query_string} #{@http_post_content}"
    if @http_path_info == '/time'
      res.status = 200
      res.content = Time.now.to_s
    else
      res.status = @http_path_info.scan(/status\/(\d+)$/).first.first.to_i rescue res.status = 200
      res.content = "statud #{res.status}"
    end
    res.send_response
  end
end

EM::run do
  puts "start HTTP server - port #{port}"
  EM::start_server('0.0.0.0', port, TestHttpServer)
end
