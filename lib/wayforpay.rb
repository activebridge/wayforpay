module Wayforpay
  extend SingleForwardable

  def_delegators :configuration,
    :merchant_account, :merchant_domain_name, :encrypt_secret_key

  def self.hold(attrs = {})
    Hold.(Constants::HOLD_ATTRS.merge(attrs))
  end

  def self.refund(attrs = {})
    Refund.(Constants::REFUND_ATTRS.merge(attrs))
  end

  def self.settle(attrs = {})
    Settle.(Constants::SETTLE_ATTRS.merge(attrs))
  end

  ##
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

require_relative 'wayforpay/util/configuration'
require_relative 'wayforpay/hold'
require_relative 'wayforpay/refund'
require_relative 'wayforpay/settle'
require_relative 'wayforpay/encrypt_field'
require_relative 'wayforpay/constants'
