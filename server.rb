#!/usr/bin/env ruby
require 'sinatra'

set :bind, '0.0.0.0'
set :port, 3000
set :server, :puma

def github(repo:, file: nil)
  file ||= repo
  ref = params[:v] ? "v#{params[:v]}" : 'master'
  redirect "https://raw.githubusercontent.com/DannyBen/#{repo}/#{ref}/#{file}"
end

not_found do
  status 404
  content_type :text
  "404 Not Found"
end

get("/rush")           { github repo: 'rush-cli', file: 'rush' }
get("/rush/setup")     { github repo: 'rush-cli', file: 'setup' }
get("/alf")            { github repo: 'alf' }
get("/alf/setup")      { github repo: 'alf', file: 'setup' }
get("/opcode")         { github repo: 'opcode', file: 'op' }
get("/opcode/setup")   { github repo: 'opcode', file: 'setup' }
get("/approvals.bash") { github repo: 'approvals.bash' }
