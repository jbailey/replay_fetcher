# # WAS GOING TO WRITE MY OWN ##
require "aws-credentials"
require "aws_signer"

include Aws::Credential

class Signer
  def initialize
    provider = Providers.new ([
      EnvProvider.new,
      SharedCredentialFileProvider.new,
    ] of Provider)

    credentials = provider.credentials
  end

  def sign
    signature = base64(hmac_sha1(credentials.secret_access_key, utf_8_encoding_of(string_to_sign)))
    authorization = "AWS #{credentials.access_key_id}:#{signature}"
  end

  def string_to_sign
    [
      http_verb.upcase,
      content_md5,
      content_type,
      date,
      (canonicalized_amz_headers + canonicalized_resource),
    ].join("\n")
  end

  def canonicalized_resource
  end

  def canonicalized_amz_headers
  end
end
