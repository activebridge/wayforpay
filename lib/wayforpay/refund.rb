module Wayforpay
  class Refund
    ##
    # required attrs: orderReference, amount, currency, comment
    def self.call(attrs = {})
      attrs.merge!(
        merchantSignature: EncryptField.(Constants::REFUND_ENCRYPT_FIELDS, attrs)
      )
      Net::HTTP.post(Constants::URL, attrs.to_json)
    end
  end
end
