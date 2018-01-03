describe Wayforpay::Refund do
  let(:url) { Wayforpay::Constants::URL }

  describe '.call' do
    let(:attrs) do
      {
        orderReference: 'new_order',
        amount: 123,
        currency: 'UAH',
        comment: 'Cancellation of a trip'
      }
    end
    let(:merchant_signature) do
      Wayforpay::EncryptField.(Wayforpay::Constants::REFUND_ENCRYPT_FIELDS, attrs)
    end
    let(:encrypted_attrs) do
      attrs.merge(merchantSignature: merchant_signature)
    end

    it "receives 'post' method for Net::HTTP" do
      expect(Net::HTTP).to receive(:post)
        .with(url, encrypted_attrs.to_json).once
      described_class.call(attrs)
    end
  end
end
