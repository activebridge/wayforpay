module Wayforpay
  module Util
    class Configuration
      attr_accessor :merchant_account, :merchant_domain_name, :encrypt_secret_key

      def merchant_account=(value)
        @merchant_account = value
      end

      def merchant_domain_name=(value)
        @merchant_domain_name = value
      end

      def encrypt_secret_key=(value)
        @encrypt_secret_key = value
      end
    end
  end
end
