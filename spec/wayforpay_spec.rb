describe Wayforpay do
  subject { described_class }

  it 'has a version number' do
    expect(Wayforpay::VERSION).not_to be nil
  end

  describe '.configure' do
    let(:merchant_account) { 'merchantAccount' }
    let(:merchant_domain_name) { 'merchantDomainName' }
    let(:encrypt_secret_key) { 'secretKey' }

    before do
      subject.configure do |config|
        config.merchant_account = merchant_account
        config.merchant_domain_name = merchant_domain_name
        config.encrypt_secret_key = encrypt_secret_key
      end
    end

    after do
      subject.instance_variable_set('@configuration', nil)
    end

    it { expect(subject.merchant_account).to eq(merchant_account) }
    it { expect(subject.merchant_domain_name).to eq(merchant_domain_name) }
    it { expect(subject.encrypt_secret_key).to eq(encrypt_secret_key) }
  end
end
