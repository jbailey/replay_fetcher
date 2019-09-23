require "option_parser"
require "http/client"
require "json"

battletag = ""

OptionParser.parse! do |parser|
  parser.banner = "Usage: fetcher [arguments]"
  parser.on("-b BATTLETAG", "--battletag BATTLETAG", "Specifies the battletag to pull for") { |name| battletag = name }
  parser.on("-h", "--help", "Show this help") { puts parser }
end

params = Hash(String, String).new
# params = {"min_id" => "1337", "existing" => "true"}
unless battletag.empty?
  params["player"] = battletag
end

while true
  params["min_parsed_id"] = "338"
  params["with_players"] = "true"
  encoded_params = HTTP::Params.encode(params)
  uri = "http://hotsapi.net/api/v1/replays?" + encoded_params
  puts uri
  response = HTTP::Client.get uri
  data = JSON.parse(response.body)
  puts "Players #{data[0]["url"]}"

  sleep(5)
end

puts "Done."
