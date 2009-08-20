require 'rubygems'
require 'rake'

@gems = "sinatra builder emk-sinatra-url-for cehoffman-sinatra-respond_to"

desc "Install required gems"
task :install do
	puts `sudo gem install sinatra #{@gems}`
end

desc "Update gems"
task :update do
	puts `sudo gem update sinatra #{@gems}`
end

desc "Run tests"
task :test do
	load 'test.rb'
end

