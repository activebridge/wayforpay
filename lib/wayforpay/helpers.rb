module Wayforpay
  module Helpers
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
