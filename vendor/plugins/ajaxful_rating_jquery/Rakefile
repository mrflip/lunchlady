require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('ajaxful_rating_jquery', '2.2.9') do |p|
  p.summary        = "Add star rating functionality to your Rails 2.3.x application. Requires jQuery."
  p.description    = "Provides a simple way to add rating functionality to your application. This is a fork of ajaxful_ratings that works with jQuery instead of Prototype and uses unobtrusive javascript instead of link_to_remote."
  p.url            = "http://github.com/kamui/ajaxful_rating_jquery"
  p.author         = "Jack Chu, Edgar J. Suarez"
  p.email          = "kamuigt@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }