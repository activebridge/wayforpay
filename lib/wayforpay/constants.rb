module Wayforpay
  module Constants
    URL = URI.parse('https://api.wayforpay.com/api').freeze

    HOLD_ENCRYPT_FIELDS = %i[merchantAccount merchantDomainName orderReference orderDate amount currency productName productCount productPrice].freeze
    REFUND_ENCRYPT_FIELDS = %i[merchantAccount orderReference amount currency].freeze
    SETTLE_ENCRYPT_FIELDS = %i[merchantAccount orderReference amount currency].freeze

    HOLD_ATTRS = {
      transactionType: 'CHARGE',
      authorizationType: 'SimpleSignature',
      merchantTransactionType: 'AUTH',
      merchantTransactionSecureType: 'NON3DS',
      apiVersion: 1
    }.freeze

    REFUND_ATTRS = {
      transactionType: 'REFUND',
      apiVersion: 1
    }.freeze

    SETTLE_ATTRS = {
      transactionType: 'SETTLE',
      apiVersion: 1
    }.freeze

    def self.hold_params
      HOLD_ATTRS.merge(
        merchantAccount: Wayforpay.merchant_account,
        merchantDomainName: Wayforpay.merchant_domain_name,
      )
    end

    def self.refund_params
      REFUND_ATTRS.merge(merchantAccount: Wayforpay.merchant_account)
    end

    def self.settle_params
      SETTLE_ATTRS.merge(merchantAccount: Wayforpay.merchant_account)
    end
  end
end
