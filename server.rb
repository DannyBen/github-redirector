#!/usr/bin/env ruby
require 'sinatra'
require 'yaml'

set :bind, '0.0.0.0'
set :port, 3000
set :server, :puma

def github(repo:, user: nil, file: nil)
  file ||= repo
  user ||= config['defaults']['user']
  ref = params[:v] ? "v#{params[:v]}" : 'master'
  redirect "https://raw.githubusercontent.com/#{user}/#{repo}/#{ref}/#{file}"
end

def config
  @config ||= YAML.load_file('config.yml')
end

not_found do
  status 404
  content_type :text
  "404 No matching redirect"
end

get '/' do
  content_type :text

  result = ["Available Routes:", ""]
  result += config['redirects'].keys.sort.map { |x| "- #{x}" }
  result += ["", "Add ?v=VERSION to get a specific version"]

  result.join "\n"
end

config['redirects'].each do |route, data|
  get route do
    github user: data['user'], repo: data['repo'], file: data['file']
  end
end
