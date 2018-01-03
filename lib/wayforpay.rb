require_relative 'wayforpay/constants'
require_relative 'wayforpay/encrypt_field'
require_relative 'wayforpay/payments'
require_relative 'wayforpay/request'
require_relative 'wayforpay/util/configuration'

module Wayforpay
  extend SingleForwardable

  def_delegators :configuration, :merchant_account,
                 :merchant_domain_name, :encrypt_secret_key

  # Pre-configure with merchant_account, merchant_domain_name
  # and encrypt_secret_key.
  def self.configure(&block)
    yield configuration
  end

  private

  ##
  # Returns an existing or instantiates a new configuration object.
  def self.configuration
    @configuration ||= Util::Configuration.new
  end
end
