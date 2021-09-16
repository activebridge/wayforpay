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
        currency: 'UAH'
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

  context '.verify' do
    let(:attrs) do
      {
        orderReference: 'new_order',
        amount: 123,
        currency: 'UAH',
        card: '4111111111111111',
        expMonth: '11',
        expYear: '2020',
        cardCvv: '111',
        cardHolder: 'TARAS BULBA'
      }
    end
    let(:request_params) do
      Wayforpay::Constants.verify_params.merge(attrs)
    end
    let(:encrypt_fields) { Wayforpay::Constants::VERIFY_ENCRYPT_FIELDS }
    it "receives 'call' method for Wayforpay::Request" do
      expect(Wayforpay::Request).to receive(:call)
        .with(encrypt_fields, request_params).once
      described_class.verify(attrs)
    end
  end

  context '.create_invoice' do
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
      Wayforpay::Constants.create_invoice_params.merge(attrs)
    end
    let(:encrypt_fields) { Wayforpay::Constants::CREATE_INVOICE_ENCRYPT_FIELDS }

    it "receives 'call' method for Wayforpay::Request" do
      expect(Wayforpay::Request).to receive(:call)
        .with(encrypt_fields, request_params).once
      described_class.create_invoice(attrs)
    end
  end

  context '.accept_invoice_payment' do
    let(:attrs) do
      {
        orderReference: 'new_order',
        time: 1415379863
      }
    end
    let(:request_params) do
      Wayforpay::Constants.accept_invoice_payment_params.merge(attrs)
    end
    let(:encrypt_fields) { Wayforpay::Constants::ACCEPT_INVOICE_PAYMENT_ENCRYPT_FIELDS }

    it "receives 'call' method for Wayforpay::Request" do
      expect(Wayforpay::Request).to receive(:call)
        .with(encrypt_fields, request_params).once
      described_class.accept_invoice_payment(attrs)
    end
  end

  context '.get_client' do
    let(:attrs) do
      {
        card: '4111111111111111'
      }
    end
    let(:request_params) do
      Wayforpay::Constants.get_client_params.merge(attrs)
    end
    let(:encrypt_fields) { Wayforpay::Constants::GET_CLIENT_ENCRYPT_FIELDS }

    it "receives 'call' method for Wayforpay::Request" do
      expect(Wayforpay::Request).to receive(:call)
        .with(encrypt_fields, request_params).once
      described_class.get_client(attrs)
    end
  end
end
