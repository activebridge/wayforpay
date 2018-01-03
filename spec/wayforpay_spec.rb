describe Wayforpay do
  subject { described_class }

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

  describe '.hold' do
    let(:hold_attrs) { Wayforpay::Constants::HOLD_ATTRS }
    let(:attrs) do
      {
        orderReference: 'new_order',
        amount: 123,
        currency: 'UAH',
        orderDate: Time.now.to_i,
        productName: ['TRIP'],
        productPrice: [123],
        productCount: [1],
        recToken: 'recToken'
      }
    end

    it "receives 'call' method for Wayforpay::Hold" do
      expect(Wayforpay::Hold)
        .to receive(:call).with(hold_attrs.merge(attrs)).once
      subject.hold(attrs)
    end
  end

  describe '.refund' do
    let(:refund_attrs) { Wayforpay::Constants::REFUND_ATTRS }
    let(:attrs) do
      {
        orderReference: 'new_order',
        amount: 123,
        currency: 'UAH',
        comment: 'Cancellation of a trip'
      }
    end

    it "receives 'call' method for Wayforpay::Refund" do
      expect(Wayforpay::Refund)
        .to receive(:call).with(refund_attrs.merge(attrs)).once
      subject.refund(attrs)
    end
  end

  describe '.settle' do
    let(:settle_attrs) { Wayforpay::Constants::SETTLE_ATTRS }
    let(:attrs) do
      {
        orderReference: 'new_order',
        amount: 123,
        currency: 'UAH'
      }
    end

    it "receives 'call' method for Wayforpay::Settle" do
      expect(Wayforpay::Settle)
        .to receive(:call).with(settle_attrs.merge(attrs)).once
      subject.settle(attrs)
    end
  end
end
