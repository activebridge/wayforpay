require 'json'
require 'net/http'

module Wayforpay
  class Request
    def self.call(encrypted_fields = [], request_params = {})
      request_params[:merchantSignature] = EncryptField.(encrypted_fields, request_params)
      Net::HTTP.post(Constants::URL, request_params.to_json)
    end
  end
end
