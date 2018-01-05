---
title: UpdateEMV
position: 1.5
type: void
description: Update a certain emv configure of your device
right_code: |
  ~~~ json
  {
    "result":"update emv configure success"
  }
  ~~~
  {: title="Response" }

  ~~~ json
  ~~~
---
function:
```objc
-(void)updateEmvAPP:(NSInteger )operationType data:(NSArray*)data  block:(void (^)(BOOL isSuccess, NSString *stateStr))updateEMVAPPBlock;
```
sample code
```objc
-(void)updateEMV{
      NSMutableDictionary * emvCapkDict = [pos getEMVAPPDict];
      NSString * c =[[emvCapkDict valueForKey:@"Terminal_Capabilities"] stringByAppendingString:[self getEMVStr:@"60B8C8"]];
      NSArray * aidArr = @[c];
      [pos updateEmvAPP:EMVOperation_update data:aidArr  block:^(BOOL isSuccess, NSString *stateStr) {
       if (isSuccess) {
        self.textViewLog.text = stateStr;
        self.textViewLog.backgroundColor = [UIColor greenColor];
        [self.updateEMVapp2 setEnabled:YES];
         }else{
        self.textViewLog.text = @"update emv app fail";
        }
      }];
}
-(NSString* )getEMVStr:(NSString *)emvStr{
        NSInteger emvLen = 0;
       if (emvStr != NULL &&![emvStr  isEqual: @""]) {
       if ([emvStr length]%2 != 0) {
       emvStr = [@"0" stringByAppendingString:emvStr];
       }
       emvLen = [emvStr length]/2;
       }else{
       NSLog(@"init emv app config str could not be empty");
       return nil;
       }
       NSData *emvLenData = [Util IntToHex:emvLen];
       NSString *totalStr = [[[Util byteArray2Hex:emvLenData] substringFromIndex:2] stringByAppendingString:emvStr];
       return totalStr;
}
```
