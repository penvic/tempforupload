---
title: EMVContactlessCardTransaction 
position: 2
type: void
description: Result of contactless EMV transaction
right_code: |
  ~~~ json
  {
      "Tap Card":
      "Format ID": 30
      "Masked PAN": "623568XXXXXXXXX9908"
      "Expiry Date": "2601"
      "Cardholder Name": 
      "PIN KSN": "00000332100300E00010"
      "Track KSN": "00000332100300E00003"
      "Service Code": 
      "Encrypted Track 1": 
      "Encrypted Track 2": "881E250CA9273CD5312337F288BDCCB4353815CD97F2A49349D10DB4E0D32726"
      "Encrypted Track 3": 
      "pinBlock": "F3E581E6A904ECE2"
      "encPAN":";
  }
  ~~~
  {: title="Response" }

  ~~~ json
  ~~~
---

function :
```objc
-(void) doTrade:(NSInteger) timeout;
-(void) doCheckCard:(NSInteger) timeout;
```
sample code:
```objc
[pos doTrade:30];[pos doCheckCard];
```
callback function :
```objc
-(void) onDoTradeResult: (DoTradeResult)result DecodeData:(NSDictionary*)decodeData;
```
~~~ javascript
tips: the difference between api doTrade and doCheckCard:
calling doCheck card , you don't have to input pin when doing swipe transaction.
~~~
