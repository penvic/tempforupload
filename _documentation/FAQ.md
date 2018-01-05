---
title: FAQ
position: 3
---


```
Q:In which function we prompt the user to swipe or insert card ?
A:onRequestWaitingUser()


Q:After swipe or insert card, which callback function return the result ? 
A:onDoTradeResult()


Q:Which function provides the EMV transaction result? What is the format of its return result?
A:onRequestOnlineProcess()
TLV data/ Type Length Value
We can get all the tlv tags by analyzing the tlv data. 


Q:How to deal with the returned data of the bank?
A:Based on the returned data of bank, we can get to know whether we have the permission to continue the transaction. 
If the current transaction is permitted , we should send:
mPos.sendOnlineProcessResult("8A023030"+"55 file data");
otherwise,we should send:
mPos.sendOnlineProcessResult("8A023035"+"55 file data");
```


