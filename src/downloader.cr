require "aws-credentials"
require "./aws_signer"

include Aws::Credentials

provider = Providers.new ([
  EnvProvider.new,
  SharedCredentialFileProvider.new,
] of Provider)

credentials = provider.credentials
# puts credentials

uri = URI.parse("http://hotsapi.s3-website-eu-west-1.amazonaws.com/725ba498-2728-d326-b6ac-11129c55b212.StormReplay")
headers = {
  "x-amz-request-payer" => "requester",
}

# AwsSigner.configure do |config|
#   config.access_key = credentials.access_key_id
#   config.secret_key = credentials.secret_access_key
#   # config.region = "eu-west-1"
#   print "config: #{config}"
# end
config = AwsSigner::Config.new
config.access_key = credentials.access_key_id
config.secret_key = credentials.secret_access_key
config.region = "eu-west-1"
AwsSigner.set_config config

puts AwsSigner.config

# AwsSigner.sign("s3", "GET", uri, headers, "")
