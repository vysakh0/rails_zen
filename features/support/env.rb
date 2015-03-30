$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'aruba/cucumber'
require 'fileutils'
require 'rspec/expectations'
require 'rspec/mocks'
require 'cucumber/rspec/doubles'
Before do
  @aruba_timeout_seconds = 5
end
