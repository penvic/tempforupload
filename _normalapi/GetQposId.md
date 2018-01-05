---
title: GetQposId
position: 1.0
type: void
description: Get device serial number.
right_code: |
  ~~~ json
   {
      "posId":"27003009117051600470",
      "psamId": "3730303030343730",
      "merchantId": 4.5,
      "vendorCode": "12/12/2013",
      "deviceNumber":     ,
      "psamNo": 
     } 
  ~~~
  {: title="Response" }

  ~~~ json
  ~~~
---

function :
```objc
-(void) getQPosId;
```
sample code :
```objc
 [pos getQPosId];
```
callback function :
```objc
-(void) onQposIdResult: (NSDictionary*)posId;
```

