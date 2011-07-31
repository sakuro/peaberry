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

      body = "// dotjs is working! //\n" + files.compact.map(&:to_s).join
      headers = {
        'Content-Length' => body.bytesize.to_s,
        'Content-Type' => 'text/javascript',
        'Access-Control-Allow-Origin' => '*'
      }
      [ 200, headers, body.lines ]
    rescue => e
      logger.error(e.message)
      [ 500, {}, [''] ]
    end
  end
end
