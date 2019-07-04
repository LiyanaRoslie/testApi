class SinoiovController < ApplicationController

  def initialize
    @scheme    = 'https'
    @host      = 'testopen.95155.com'
    @username  = 'd5280f2b-7629-45ab-b0b5-bf7cb72918f6'
    @password  = 'K2S3CEiv823207160o65UnpVz3I9jq'
    @cliend_id = '82e938ec-8666-47b9-8a4b-34ba836e1c72'
    @key = 'CTFOTRV1'
  end

  def show
    #req = RestClient.post 'https://testopen.95155.com/apis/login/', {user: '#{@username}', pwd: '#{@password}', client_id: '#{@cliend_id}'}
    encrypted = encrypt("user=#{@username}&pwd=#{@password}")
    req = Net::HTTP::Post.new("/apis/login/#{encrypted}\?client_id\=#{@cliend_id}")
    response = call(req)
    if response
      json_response = JSON.parse(decrypt(response.body))
      flash[:success] = "Response: #{json_response}."
    else
    end
  end

  private
    def encrypt(str)
      cipher = OpenSSL::Cipher::DES.new.encrypt.tap do |obj|
        obj.key = @key
        obj.iv  = @key
      end
      (cipher.update(str) + cipher.final).unpack1('H*').upcase
    end

    def decrypt(str)
      cipher = OpenSSL::Cipher::DES.new.decrypt.tap do |obj|
        obj.key = @key
        obj.iv  = @key
      end
      cipher.update([str].pack('H*')) + cipher.final
    end

    def call(req)
      url = URI.parse("#{@scheme}://#{@host}/")

      https = Net::HTTP.new(url.host, url.port)

      https.set_debug_output($stdout)

      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      https.start do |http|
        http.request(req)
      end
    end

end
