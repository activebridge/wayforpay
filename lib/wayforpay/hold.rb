module Wayforpay
  class Hold
    ##
    # required attrs: orderReference, amount, currency, orderDate,
    # productName[], productPrice[], productCount[],
    # (card + expMonth + expYear + cardCvv + cardHolder) or recToken
    def self.call(attrs = {})
      attrs.merge!(
        merchantSignature: EncryptField.(Constants::HOLD_ENCRYPT_FIELDS, attrs)
      )
      Net::HTTP.post(Constants::URL, attrs.to_json)
    end
  end
end
