module Wayforpay
  class EncryptField
    attr_reader :keys, :attrs

    def initialize(keys, attrs)
      @keys, @attrs = keys, attrs
    end

    def self.call(keys, attrs = {})
      new(keys, attrs).call
    end

    def call
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('md5'), Wayforpay.encrypt_secret_key, signature_string)
    end

    def signature_string
      attrs.values_at(*keys).compact.join(';')
    end
  end
end
