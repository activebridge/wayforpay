module Wayforpay
  module Payments
    # required attrs: orderReference, amount, currency, orderDate,
    # productName[], productPrice[], productCount[],
    # (card + expMonth + expYear + cardCvv + cardHolder) or recToken
    def self.hold(attrs = {})
      request_params = Constants.hold_params.merge(attrs)
      Wayforpay::Request.(Constants::HOLD_ENCRYPT_FIELDS, request_params)
    end

    # required attrs: orderReference, amount, currency, comment
    def self.refund(attrs = {})
      request_params = Constants.refund_params.merge(attrs)
      Wayforpay::Request.(Constants::REFUND_ENCRYPT_FIELDS, request_params)
    end

    # required attrs: orderReference, amount, currency
    def self.settle(attrs = {})
      request_params = Constants.settle_params.merge(attrs)
      Wayforpay::Request.(Constants::SETTLE_ENCRYPT_FIELDS, request_params)
    end

    # required attrs: orderReference, amount, currency, card, expMonth, expYear, cardCvv, cardHolder
    def self.verify(attrs = {})
      request_params = Constants.verify_params.merge(attrs)
      Wayforpay::Request.(Constants::VERIFY_ENCRYPT_FIELDS, request_params)
    end

    # required attrs: orderReference, amount, currency, orderDate,
    # productName[], productPrice[], productCount[]
    def self.create_invoice(attrs = {})
      request_params = Constants.create_invoice_params.merge(attrs)
      Wayforpay::Request.(Constants::CREATE_INVOICE_ENCRYPT_FIELDS, request_params)
    end

    # required attrs: orderReference, status, time
    def self.accept_invoice_payment(attrs = {})
      request_params = Constants.accept_invoice_payment_params.merge(attrs)
      Wayforpay::Request.(Constants::ACCEPT_INVOICE_PAYMENT_ENCRYPT_FIELDS, request_params)
    end

    # required attrs: recToken or card
    def self.get_client(attrs = {})
      request_params = Constants.get_client_params.merge(attrs)
      Wayforpay::Request.(Constants::GET_CLIENT_ENCRYPT_FIELDS, request_params)
    end
  end
end
