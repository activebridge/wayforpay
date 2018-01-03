describe Wayforpay::Util::Configuration do
  let(:config) { described_class.new }
  let(:merchant_account) { 'merchantAccount' }
  let(:merchant_domain_name) { 'merchantDomainName' }
  let(:encrypt_secret_key) { 'secretKey' }

  before do
    config.merchant_account = merchant_account
    config.merchant_domain_name = merchant_domain_name
    config.encrypt_secret_key = encrypt_secret_key
  end

  it { expect(config.merchant_account).to eq(merchant_account) }
  it { expect(config.merchant_domain_name).to eq(merchant_domain_name) }
  it { expect(config.encrypt_secret_key).to eq(encrypt_secret_key) }
end
