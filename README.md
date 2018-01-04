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
  Or install it yourself as:
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
## Contributing

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request
  
## Copyright

Copyright (c) 2018 Active Bridge, LLC. See LICENSE for details.
