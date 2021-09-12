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

    # required attrs: orderReference, orderDate, amount, currency, productName[], productCount[], productPrice[]
    def self.purchase_form(attrs = {})
      attrs = Constants.purchase_form_params.merge(attrs)
      attrs[:merchantSignature] = EncryptField.call(Constants::PURCHASE_FORM_ENCRYPT_FIELDS, attrs)
      button = attrs.delete(:buttonHtml) || '<button type="submit">Pay</button>'

      form_fields = attrs.map do |key, value|
        if value.is_a?(Array)
          value.map { |element| "<input type=\"hidden\" name=\"#{key}[]\" value=\"#{element}\">" }
        else
          "<input type=\"hidden\" name=\"#{key}\" value=\"#{value}\">"
        end
      end.flatten.join("\n")

      <<~FORM
        <form method="post" action="https://secure.wayforpay.com/pay" accept-charset="utf-8">
          #{form_fields}
          #{button}
        </form>
      FORM
    end

    # required attrs: merchantAccount, orderReference, amount, currency, authCode, cardPan, transactionStatus, reasonCode
    def self.valid_purchase_response?(response)
      response = response.transform_keys(&:to_sym)
      response[:merchantSignature] == EncryptField.call(Constants::PURCHASE_RESPONSE_ENCRYPT_FIELDS, response)
    end
  end
end
