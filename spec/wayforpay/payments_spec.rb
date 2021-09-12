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

  describe '.purchase_form' do
    let(:attrs) do
      {
        orderDate: 1631273784,
        orderReference: 1,
        amount: 10,
        currency: "UAH",
        productName: ['First product', 'Second product'],
        productCount: [1, 2],
        productPrice: [2, 4],
        buttonHtml: "<button type='submit'>Let's pay</button>"
      }
    end

    let(:form) do
      <<~FORM.gsub(/\s+/, ' ').strip
          <form method="post" action="https://secure.wayforpay.com/pay" accept-charset="utf-8">
            <input type="hidden" name="merchantAuthType" value="SimpleSignature">
            <input type="hidden" name="merchantAccount" value="merchantAccount">
            <input type="hidden" name="merchantDomainName" value="merchantDomainName">
            <input type="hidden" name="orderDate" value="1631273784">
            <input type="hidden" name="orderReference" value="1">
            <input type="hidden" name="amount" value="10">
            <input type="hidden" name="currency" value="UAH">
            <input type="hidden" name="productName[]" value="First product">
            <input type="hidden" name="productName[]" value="Second product">
            <input type="hidden" name="productCount[]" value="1">
            <input type="hidden" name="productCount[]" value="2">
            <input type="hidden" name="productPrice[]" value="2">
            <input type="hidden" name="productPrice[]" value="4">
            <input type="hidden" name="merchantSignature" value="2b4c782006887cec0011017caa3ce960">
          <button type='submit'>Let's pay</button>
        </form>
      FORM
    end

    before do
      Wayforpay.configure do |config|
        config.merchant_account = 'merchantAccount'
        config.merchant_domain_name = 'merchantDomainName'
        config.encrypt_secret_key = 'secretKey'
      end
    end

    it 'generates a payment form' do
      expect(described_class.purchase_form(attrs).gsub(/\s+/, ' ').strip).to eq(form)
    end
  end

  describe '.valid_purchase_response?' do
    subject { described_class.valid_purchase_response?(response) }

    let(:response) do
      {
        "merchantAccount" => Wayforpay.merchant_account,
        "orderReference" => "1",
        "merchantSignature" => signature,
        "amount" => 1,
        "currency" => "USD",
        "authCode" => "502899",
        "email" => "john.doe@example.com",
        "phone" => "12345678901",
        "createdDate" => 1631271158,
        "processingDate" => 1631271376,
        "cardPan" => "51****1234",
        "cardType" => "MasterCard",
        "issuerBankCountry" => "USA",
        "issuerBankName" => "Bank of America",
        "recToken" => "79e66923-49f1-4f0e-88eb-4acf1e6fcf23",
        "transactionStatus" => "Approved",
        "reason" => "Ok",
        "reasonCode" => 1100,
        "fee" => 0.03,
        "paymentSystem" => "card",
        "acquirerBankName" => "WayForPay",
        "cardProduct" => "debit",
        "clientName" => "JOHN DOE"
      }
    end

    before do
      Wayforpay.configure do |config|
        config.merchant_account = 'merchantAccount'
        config.merchant_domain_name = 'merchantDomainName'
        config.encrypt_secret_key = 'secretKey'
      end
    end

    context 'when the signature is valid' do
      let(:signature) { '6ca17365705fb39d2415a5a3e374e302' }

      it { is_expected.to be(true) }
    end

    context 'when the signature is invalid' do
      let(:signature) { '6ca17365705fb39d2415a5a3e374e301' }

      it { is_expected.to be(false) }
    end
  end
end
