describe Wayforpay::Helpers do
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
