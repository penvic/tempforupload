---
title: MagneticStripCardTransaction
position: 3
type: get
description: Result of magnetic strip card transaction
right_code: |
  ~~~ json
  {
    "Card Swiped":
    "Format ID": 30
    "Masked PAN": "623568XXXXXXXXX9908"
    "Expiry Date": "2601"
    "Cardholder Name": 
    "PIN KSN": "00000332100300E0000E"
    "Track KSN": "00000332100300E00002"
    "Service Code": 220
    "Encrypted Track 1": 
    "Encrypted Track 2": "817D3936CBC58D42D53829142F63AEEC8DB77ABBA17FC32D"
    "Encrypted Track 3": 
    "pinBlock": "CEFBDCEAC0B025EB"
    "encPAN":   "
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
