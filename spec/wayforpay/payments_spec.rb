describe Wayforpay::Payments do
  context '.hold' do
    let(:attrs) do
      {
        orderReference: 'new_order',
        amount: 123,
        currency: 'UAH',
        orderDate: 1514214411,
        productName: ['TRIP'],
        productPrice: [123],
        productCount: [1],
        recToken: 'recToken'
      }
    end
    let(:request_params) do
      Wayforpay::Constants.hold_params.merge(attrs)
    end
    let(:encrypt_fields) { Wayforpay::Constants::HOLD_ENCRYPT_FIELDS }

    it "receives 'call' method for Wayforpay::Request" do
      expect(Wayforpay::Request).to receive(:call)
        .with(encrypt_fields, request_params).once
      described_class.hold(attrs)
    end
  end

  context '.refund' do
    let(:attrs) do
      {
        orderReference: 'new_order',
        amount: 123,
        currency: 'UAH',
        comment: 'Cancellation of a trip'
      }
    end
    let(:request_params) do
      Wayforpay::Constants.refund_params.merge(attrs)
    end
    let(:encrypt_fields) { Wayforpay::Constants::REFUND_ENCRYPT_FIELDS }

    it "receives 'call' method for Wayforpay::Request" do
      expect(Wayforpay::Request).to receive(:call)
        .with(encrypt_fields, request_params).once
      described_class.refund(attrs)
    end
  end

  context '.settle' do
    let(:attrs) do
      {
        orderReference: 'new_order',
        amount: 123,
        currency: 'UAH',
      }
    end
    let(:request_params) do
      Wayforpay::Constants.settle_params.merge(attrs)
    end
    let(:encrypt_fields) { Wayforpay::Constants::SETTLE_ENCRYPT_FIELDS }

    it "receives 'call' method for Wayforpay::Request" do
      expect(Wayforpay::Request).to receive(:call)
        .with(encrypt_fields, request_params).once
      described_class.settle(attrs)
    end
  end
end
