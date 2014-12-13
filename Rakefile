#!/usr/bin/env ruby
require File.expand_path('../config/application', __FILE__)

SimpleApp::Application.load_tasks
begin
  load File.expand_path("../spring", __FILE__)
rescue LoadError
end
require 'bundler/setup'
#load Gem.bin_path('rake', 'rake')
