describe Wayforpay::Request do
  before do
    Wayforpay.configure do |config|
      config.merchant_account = 'merchantAccount'
      config.merchant_domain_name = 'merchantDomainName'
      config.encrypt_secret_key = 'secretKey'
    end
  end

  let(:url) { Wayforpay::Constants::URL }

  context '.call' do
    let(:merchant_signature) { Wayforpay::EncryptField.(encrypt_fields, request_attrs) }
    let(:encrypted_attrs) { request_attrs.merge(merchantSignature: merchant_signature) }

    subject { described_class.call(encrypt_fields, request_attrs) }

    context "hold params" do
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
      let(:encrypt_fields) { Wayforpay::Constants::HOLD_ENCRYPT_FIELDS }
      let(:request_attrs) { Wayforpay::Constants.hold_params.merge(attrs) }

      it "receives 'post' method for Net::HTTP" do
        expect(Net::HTTP).to receive(:post)
          .with(url, encrypted_attrs.to_json).once
        subject
      end
    end

    context "refund params" do
      let(:attrs) do
        {
          orderReference: 'new_order',
          amount: 123,
          currency: 'UAH',
          comment: 'Cancellation of a trip'
        }
      end
      let(:encrypt_fields) { Wayforpay::Constants::REFUND_ENCRYPT_FIELDS }
      let(:request_attrs) { Wayforpay::Constants.refund_params.merge(attrs) }

      it "receives 'post' method for Net::HTTP" do
        expect(Net::HTTP).to receive(:post)
          .with(url, encrypted_attrs.to_json).once
        subject
      end
    end

    context "settle params" do
      let(:attrs) do
        {
          orderReference: 'new_order',
          amount: 123,
          currency: 'UAH',
        }
      end
      let(:encrypt_fields) { Wayforpay::Constants::SETTLE_ENCRYPT_FIELDS }
      let(:request_attrs) { Wayforpay::Constants.settle_params.merge(attrs) }

      it "receives 'post' method for Net::HTTP" do
        expect(Net::HTTP).to receive(:post)
          .with(url, encrypted_attrs.to_json).once
        subject
      end
    end

    context 'verify params' do
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
      let(:encrypt_fields) { Wayforpay::Constants::VERIFY_ENCRYPT_FIELDS }
      let(:request_attrs) { Wayforpay::Constants.verify_params.merge(attrs) }

      it "receives 'post' method for Net::HTTP" do
        expect(Net::HTTP).to receive(:post)
          .with(url, encrypted_attrs.to_json).once
        subject
      end
    end

    context "create_invoice params" do
      let(:attrs) do
        {
          orderReference: 'new_order',
          amount: 123,
          currency: 'UAH',
          orderDate: 1514214411,
          productName: ['TRIP'],
          productPrice: [123],
          productCount: [1]
        }
      end
      let(:encrypt_fields) { Wayforpay::Constants::CREATE_INVOICE_ENCRYPT_FIELDS }
      let(:request_attrs) { Wayforpay::Constants.create_invoice_params.merge(attrs) }

      it "receives 'post' method for Net::HTTP" do
        expect(Net::HTTP).to receive(:post)
          .with(url, encrypted_attrs.to_json).once
        subject
      end
    end
  end
end
