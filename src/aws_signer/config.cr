module AwsSigner
  class Config
    @access_key : String?
    @secret_key : String?
    @region : String?

    def access_key=(access_key)
      @access_key = access_key
    end

    def access_key
      @access_key.as(String)
    end

    def secret_key=(secret_key)
      @secret_key = secret_key
    end

    def secret_key
      @secret_key.as(String)
    end

    def region=(region)
      @region = region
    end

    def region
      begin
        @region.as(String)
      rescue
        @region = "us-east-1"
      end
    end
  end
end
