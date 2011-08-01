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
      headers = Rack::Utils::HeaderHash.new
      request = Rack::Request.new(env)
      files = []
      files << @sprockets.find_asset('default.js')
      files << @sprockets.find_asset(request.path_info.sub(/^\//, ''))

      body = "// dotjs is working! //\n" + files.compact.map(&:to_s).join
      headers['Content-Length'] = body.bytesize.to_s
      headers['Content-Type'] = 'text/javascript'
      headers['Access-Control-Allow-Origin'] = '*'
      [ 200, headers, body.lines ]
    end
  end
end
