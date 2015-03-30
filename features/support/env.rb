$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'aruba/cucumber'
require 'fileutils'
require 'rspec/expectations'
Before do
    @aruba_timeout_seconds = 5
end
