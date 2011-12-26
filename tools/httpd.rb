#!/usr/bin/evn ruby
require 'rubygems'
require 'eventmachine'
require 'evma_httpserver'

port = ARGV.shift.to_i
port = 8080 if port < 1

class TestHttpServer < EM::Connection
  include EM::HttpServer

  def process_http_request
    res = EM::DelegatedHttpResponse.new(self)
    puts "* http #{@http_request_method} #{@http_path_info} #{@http_query_string} #{@http_post_content}"
    code = @http_path_info.scan(/status\/(\d+)$/).first.first.to_i rescue code = 200
    res.content = "statud #{code}"
    res.status = code
    res.send_response
  end
end

EM::run do
  EM::start_server('0.0.0.0', port, TestHttpServer)
  puts "start HTTP server - port #{port}"
end
