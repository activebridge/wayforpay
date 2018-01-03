require 'json'
require 'net/http'

module Wayforpay
  class Request
    def self.call(encrypted_fields, request_attrs)
      request_attrs[:merchantSignature] = EncryptField.(encrypted_fields, request_attrs)
      Net::HTTP.post(Constants::URL, request_attrs.to_json)
    end
  end
end
