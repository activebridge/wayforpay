module Wayforpay
  class Settle
    ##
    # required attrs: orderReference, amount, currency
    def self.call(attrs = {})
      attrs.merge!(
        merchantSignature: EncryptField.(Constants::SETTLE_ENCRYPT_FIELDS, attrs)
      )
      Net::HTTP.post(Constants::URL, attrs.to_json)
    end
  end
end
