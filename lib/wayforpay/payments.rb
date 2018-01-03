module Wayforpay
  module Payments
    # required attrs: orderReference, amount, currency, orderDate,
    # productName[], productPrice[], productCount[],
    # (card + expMonth + expYear + cardCvv + cardHolder) or recToken
    def self.hold(attrs = {})
      request_params = Wayforpay::Constants.hold_params.merge(attrs)
      Wayforpay::Request.(Constants::HOLD_ENCRYPT_FIELDS, request_params)
    end

    # required attrs: orderReference, amount, currency, comment
    def self.refund(attrs = {})
      request_params = Wayforpay::Constants.refund_params.merge(attrs)
      Wayforpay::Request.(Constants::REFUND_ENCRYPT_FIELDS, request_params)
    end

    # required attrs: orderReference, amount, currency
    def self.settle(attrs = {})
      request_params = Wayforpay::Constants.settle_params.merge(attrs)
      Wayforpay::Request.(Constants::SETTLE_ENCRYPT_FIELDS, request_params)
    end
  end
end
