---
title: MKSK
position: 1.1
type: void
description: Key management - MKSK
right_code: |
  ~~~ json
  {
    "set master key result" :"set masterkey success"
  }
  {
    "update workkey result" :UpdateInformationResult_UPDATE_SUCCESS
  }
  ~~~
  {: title="Response" }

  ~~~ json
  
---
~~~javascript
Set Master Key
~~~
function:
```objc
-(void) setMasterKey:(NSString *)key  checkValue:(NSString *)chkValue keyIndex:(NSInteger) mKeyIndex;
```
sample code:
```objc
NSString *masterKey = @"89EEF94D28AA2DC189EEF94D28AA2DC1";//111111111111111111111111
NSString *masCheck = @"82E13665B4624DF5";

[pos setMasterKey:masterKey checkValue:pikCheck keyIndex:masCheck];
```
callback function :
```objc
-(void) onReturnSetMasterKeyResult:(BOOL)isSuccess;
```
~~~javascript
Update WorkKey
~~~
function
```objc
NSString * pik = @"89EEF94D28AA2DC189EEF94D28AA2DC1";
NSString * pikCheck = @"82E13665B4624DF5";

NSString * trk = @"89EEF94D28AA2DC189EEF94D28AA2DC1";
NSString * trkCheck = @"82E13665B4624DF5";

NSString * mak = @"89EEF94D28AA2DC189EEF94D28AA2DC1";
NSString * makCheck = @"82E13665B4624DF5";
[pos udpateWorkKey:pik pinKeyCheck:pikCheck trackKey:trk trackKeyCheck:trkCheck macKey:mak macKeyCheck:makCheck keyIndex:keyIndex];
```
callback function :
```objc
-(void) onRequestUpdateWorkKeyResult:(UpdateInformationResult)updateInformationResult;
```





