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

      path = request.path_info
      files = []
      files << @sprockets.find_asset('default.js')
      files << @sprockets.find_asset(path.sub(/^\//, ''))

      body = "// dotjs is working! //\n" + files.compact.map(&:to_s).join

      headers['Content-Length'] = body.bytesize.to_s
      headers['Content-Type'] = 'text/javascript'
      origin = env['HTTP_ORIGIN'].to_s.split(/;\s+/)
      search = path.gsub('/','').gsub(/\.js$/,'') + '$'
      if origin && origin.length == 1 && path.length != 1 && origin[0].match(search)
        headers['Access-Control-Allow-Origin'] = origin[0]
      end

      [ Rack::Utils.status_code(:ok), headers, body.lines ]
    rescue ExecJS::ProgramError => e # CoffeeScript->JavaScript
      @sprockets.send(:expire_index!)
      raise e.class, e.message.sub(%r<^(\s+\(in) .*/(\.js/)>) { "#$1 #$2" }
    end
  end

end
