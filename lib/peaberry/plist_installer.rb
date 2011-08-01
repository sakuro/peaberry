# -*- encoding: UTF-8 -*-

require 'erb'

module Peaberry
  class PlistInstaller
    PLIST_ERB_PATH = File.join(File.dirname(__FILE__), '../../com.github.peaberry.plist.erb')
    PLIST_PATH = File.expand_path('~/Library/LaunchAgents/com.github.peaberry.plist')
    def install
      open(PLIST_PATH, 'w') do |plist|
        ruby_bin_path =
          if RbConfig.respond_to?(:ruby)
            RbConfig.ruby
          else
            File.join(RbConfig::CONFIG['bindir'], RbConfig::CONFIG['ruby_install_name'])
          end
        peaberry_script_path = File.expand_path(File.join(File.dirname(__FILE__), '../../bin/peaberry'))
        plist.print ERB.new(File.read(PLIST_ERB_PATH)).result(binding)
      end
      system 'launchctl', 'load', PLIST_PATH
    end
  end
end
