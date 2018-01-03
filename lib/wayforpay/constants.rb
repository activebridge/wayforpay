module Wayforpay
  module Constants
    URL = URI.parse('https://api.wayforpay.com/api').freeze

    HOLD_ENCRYPT_FIELDS = %i[merchantAccount merchantDomainName orderReference orderDate amount currency productName productCount productPrice].freeze
    REFUND_ENCRYPT_FIELDS = %i[merchantAccount orderReference amount currency].freeze
    SETTLE_ENCRYPT_FIELDS = %i[merchantAccount orderReference amount currency].freeze

    HOLD_ATTRS = {
      transactionType: 'CHARGE',
      merchantAccount: Wayforpay.merchant_account,
      merchantDomainName: Wayforpay.merchant_domain_name,
      authorizationType: 'SimpleSignature',
      merchantTransactionType: 'AUTH',
      merchantTransactionSecureType: 'NON3DS',
      apiVersion: 1
    }.freeze

    REFUND_ATTRS = {
      transactionType: 'REFUND',
      merchantAccount: Wayforpay.merchant_account,
      apiVersion: 1
    }.freeze

    SETTLE_ATTRS = {
      transactionType: 'SETTLE',
      merchantAccount: Wayforpay.merchant_account,
      apiVersion: 1
    }.freeze
  end
end
