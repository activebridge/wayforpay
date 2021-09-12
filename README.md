[![Gem Version](http://img.shields.io/gem/v/wayforpay.svg)](https://rubygems.org/gems/wayforpay)

## Installation

  Add this line to your application's `Gemfile`:
  ```ruby
  gem 'wayforpay'
  ```
  And then execute:
  ```ruby
  $ bundle install
  ```
  To manually install `wayforpay` via Rubygems just run:
  ```ruby
  $ gem install wayforpay
  ```

## Documentation
[Wayforpay API Docs](https://wiki.wayforpay.com/display/WADE/Wayforpay+Api+documentations+ENG)

## Usage

  ```ruby
  require 'wayforpay'
  ```
  Create new file `config/initializers/wayforpay.rb` and put your own credentials here (**required**):

  ```ruby
  Wayforpay.configure do |config|
      config.merchant_account = 'test_merch_n1' # Seller identifier. This value is assigned to You from the side of WayForPay
      config.merchant_domain_name = 'example.com'
      config.encrypt_secret_key = 'flk3409refn54t54t*FNJRET'
  end
  ```
  Click [here](https://wiki.wayforpay.com/display/WADE/Test+details) for more information.

## Payments
  ### Blocking money on the payment card ([Hold](https://wiki.wayforpay.com/pages/viewpage.action?pageId=1736987))

  ```ruby
  Wayforpay::Payments.hold(parameters)
  ```

  Required parameters:
   
  | Parameter         | Description                                            |
  | ----------------- | ------------------------------------------------------ |
  | orderReference    | Unique number of the order in merchant’s system        |
  | orderDate         | Date of order placing                                  |
  | amount            | Amount of refund                                       |
  | currency          | Currency of order: UAH (USD, EUR)                      |
  | productName[]     | Array with the names of ordered products               |
  | productPrice[]    | Array with the prices per product unit                 |
  | productCount[]    | Array with the quantity of ordered goods by each item  |
  | *card*            | Card number 16 characters                              |
  | *expMonth*        | Card Expiry Date (mounth) - MM                         | 
  | *expYear*         | Card Expiry Date (year) - YY                           | 
  | *cardCvv*         | Card Security Code CVV / CVV2                          |
  | *cardHolder*      | Cardholder Name, as indicated on the card              |
  | *recToken*        | Card token for recarring withdrawals, without client (without reference to card details) |
   
  ***Note: fields (card+expMonth+expYear+cardCvv+cardHolder) or recToken should be required.***
  
  An example of request:
  
  ```ruby
  {
    "orderReference": "myOrder1",
    "orderDate": 1421412898,
    "amount": 0.13,
    "currency": "UAH",
    "card": "4111111111111111",
    "expMonth": "11",
    "expYear": "2020",
    "cardCvv": "111",
    "cardHolder": "TARAS BULBA",
    "productName": ["Samsung WB1100F","Samsung Galaxy Tab 4 7.0 8GB 3G Black"],
    "productPrice": [21.1,30.99],
    "productCount": [1,2]
  }
  ```

  ### Refund/Cancellation of payment ([Refund](https://wiki.wayforpay.com/pages/viewpage.action?pageId=1736981))

  ```ruby
  Wayforpay::Payments.refund(parameters)
  ```

  Required parameters:
    
  | Parameter         | Description                                     |
  | ----------------- | ----------------------------------------------- |
  | orderReference    | Unique number of the order in merchant’s system |
  | amount            | Amount of refund                                |
  | currency          | Currency of order: UAH                          |
  | comment           | Merchant  Comment, Description reversal reason  |

  An example of request:
  
  ```ruby
  {
    "orderReference": "DH783023",
    "amount": 100,
    "currency": "UAH",
    "comment": "Not in stock"
  }
  ```

  ### Withdrawal of blocked amount ([Settle](https://wiki.wayforpay.com/pages/viewpage.action?pageId=1736989))

  ```ruby
  Wayforpay::Payments.settle(parameters)
  ```

  Required parameters:
    
  | Parameter         | Description                                     |
  | ----------------- | ----------------------------------------------- |
  | orderReference    | Unique number of the order in merchant’s system |
  | amount            | The amount of write-offs confirmation           |
  | currency          | Write-off  currency                             |

  An example of request:
  
  ```ruby
  {
    "orderReference": "DH783023",
    "amount": 100 ,
    "currency": "UAH"
  }
  ```

  ### Creating invoices to the clients for payment for goods/services. ([Invoice](https://wiki.wayforpay.com/display/WADE/Invoice))

  ```ruby
  Wayforpay::Payments.create_invoice(parameters)
  ```

  Required parameters:
   
  | Parameter         | Description                                            |
  | ----------------- | ------------------------------------------------------ |
  | orderReference    | Unique number of the order in merchant’s system        |
  | orderDate         | Date of order placing                                  |
  | amount            | Amount of refund                                       |
  | currency          | Currency of order: UAH (USD, EUR)                      |
  | productName[]     | Array with the names of ordered products               |
  | productPrice[]    | Array with the prices per product unit                 |
  | productCount[]    | Array with the quantity of ordered goods by each item  |
   
  An example of request:
  
  ```ruby
  {
    "orderReference": "myOrder1",
    "orderDate": 1421412898,
    "amount": 0.13,
    "currency": "UAH",
    "productName": ["Samsung WB1100F","Samsung Galaxy Tab 4 7.0 8GB 3G Black"],
    "productPrice": [21.1,30.99],
    "productCount": [1,2]
  }
  ```

  An example of response:
  
  ```ruby
  {
    "reason": "1100",
    "reasonCode": "Ok",
    "invoiceUrl": "https://secure.wayforpay.com/invoice/i99edb6518fb5"
  }
  ```

  ### Acceptance of invoice payments. ([Invoice](https://wiki.wayforpay.com/display/WADE/Invoice), scroll down)

  ```ruby
  Wayforpay::Payments.accept_invoice_payment(parameters)
  ```

  Required parameters:

  | Parameter         | Description                                            |
  | ----------------- | ------------------------------------------------------ |
  | orderReference    | Unique number of the order in merchant’s system        |
  | time              | Time of acceptance                                     |

  An example of request:

  ```ruby
  {
    "orderReference": "myOrder1",
    "time": 1421412898
  }
  ```

  ### Receiving client data. ([Get Client](https://wiki.wayforpay.com/pages/viewpage.action?pageId=2424999))

  ```ruby
  Wayforpay::Payments.get_client(parameters)
  ```

  Required parameters: one of card or recToken !

  | Parameter         | Description                                            |
  | ----------------- | ------------------------------------------------------ |
  | *card*              | Card number 16 characters                              |
  | *recToken*          | Card token                                             |

  ***Note: field card or recToken should be required.***

  An example of request:

  ```ruby
  {
    "card": "4111111111111111"
  }
  ```

  ```ruby
  {
    "recToken": "55111111-1111-0000-9988-68c457123456"
  }
  ```

  ### Generate Purchase form. ([Accept payment (Purchase)](https://wiki.wayforpay.com/en/view/852102))
  
  To generate a purchase button HTML you need to:
  
  ```ruby
  Wayforpay::Payments.purchase_form(parameters)
  ```

  Required parameters:
  
| Parameter         | Description                                            |
  |-------------------|--------------------------------------------------------|
  | *orderReference*  | Uniq order id                                          |
  | *orderDate*       | Order date in Uniq Timestamp format                    |
  | *amount*          | Total order amount                                     |
  | *currency*        | Order currency in ISO format (USD, UAH, CAD)           |
  | *productName*     | An array of purchased products                         |
  | *productCount*    | The number of each product in the purchase             |
  | *productPrice*    | The each product price                                 |

  An example of the call:
  
  ```erbruby
    # checkout.html.erb
    <%= Wayforpay::Payments.purchase_form(
      orderDate: @order.created_at.to_i,
      orderReference: "#{@order.id}/#{SecureRandom.uuid}", # add something uniq not to have (1112) Duplicate Order ID 
      amount: @order.amount,
      currency: @order.currency,
      productName: @order.items.map(&:product_name),
      productCount: @order.items.map(&:count),
      productPrice: @order.items.map(&:price),
      serviceUrl: 'https://mysupersite.com/checkout/confirm',
      buttonHtml: "<button type='submit' class='btn btn-primary'>Let's buy the ticket!</button>" # customized button
    ) %>
  ```
  then at the `checkout/confirm` path you can check the response from the server:
  ```ruby
    @order = Order.find(params[:orderReference].split('/').first) # take order by it's id

    if WayforpayForm.valid_purchase_response?(params.to_unsafe_h) && params[:reasonCode] == 1100
      @order.payed!
    end
  ```

## Contributing

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request
  
## Copyright

Copyright (c) 2018 Active Bridge, LLC. See LICENSE for details.
