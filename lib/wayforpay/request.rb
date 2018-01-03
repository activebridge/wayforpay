module Wayforpay
  class Request
    def self.call(encrypted_fields, request_attrs)
      request_attrs[:merchantSignature] = EncryptField.(encrypted_fields, request_attrs)
      Net::HTTP.post(Constants::URL, attrs.to_json)
    end
  end
end
