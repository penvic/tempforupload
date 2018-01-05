---
title: GetPin
position: 1.3
type: void
description: Input pin and generate pinblock when necessary 
right_code: |
  ~~~ json
  {
     "encryptMode" :16;
     "ksn": "00000332100300E00015";
     "pin": "CE88BD802C1DABE7";

  }
  ~~~
  {: title="Response" }

  ~~~ json
  ~~~
---
function:
```objc
- (void)getPin:(NSInteger)encryptType keyIndex:(NSInteger)keyIndex maxLen:(NSInteger)maxLen typeFace:(NSString *)typeFace cardNo:(NSString *)cardNo data:(NSString *)data delay:(NSInteger)timeout withResultBlock:(void (^)(BOOL isSuccess, NSDictionary * result))getPinBlock;
```
sample code:
```objc
      "NSString *a = [Util byteArray2Hex:[Util stringFormatTAscii:@"622526XXXXXX5453"]];
       [pos getPin:1 keyIndex:1 maxLen:6 typeFace:@"Pls Input Pin" cardNo:a data:@"" delay:30 withResultBlock:^(BOOL isSuccess, NSDictionary *result) {
       NSLog(@"result: %@",result);
       }];"
```
callback function : 
```objc
-(void) onReturnGetPinResult:(NSDictionary*)decodeData;
```
