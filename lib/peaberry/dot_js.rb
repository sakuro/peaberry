# -*- encoding: UTF-8 -*-

require 'rack'
require 'coffee-script'
require 'sprockets'

module Peaberry
  class DotJs

    def initialize
      @sprockets = Sprockets::Environment.new
      dot_js_dir = File.expand_path('~/.js')
      @sprockets.append_path(dot_js_dir)
    end

    def call(env)
      request = Rack::Request.new(env)
      files = []
      files << @sprockets.find_asset('default.js')
      files << @sprockets.find_asset(request.path_info.sub(/^\//, ''))
      body = files.compact.map(&:to_s).join
      status_code = body.empty? ? 204 : 200
      headers = {
        'Content-Length' => body.bytesize.to_s,
        'Content-Type' => 'application/javascript',
        'Access-Control-Allow-Origin' => '*'
      }
      [ status_code, headers, body.lines ]
    end
  end
end
