---
title: Digital Envelope
position: 2
right_code: |
  ~~~ javascript
  https://gitlab.com/dspread
  ~~~
 
---


```
A single BDK (base derived key) able to facilitate 500,000 devices by deriving same amount IPEK keys. Therefore, by having several BDKs you may able to support millions of devices which able to use a unique key for every instance they are going to encrypt data.
You can store your BDKs in an industrial used HSM (Hardware Secure Module). Then send IPEK (Initial Key) file to vendor for devices key injection, also you can inject and update keys on your own app with DSPREAD SDK API, which is using digital envelope to inject keys into terminal 
```
```
1.First factory will inject the encryption key from Client/Bank, then inject these keys into QPOS

2.After above step, QPOS is capable of protecting card and transaction data by encrypting them. Then send the encrypted card to acquirer. 

3.Finally, acquirer will receive and decrypt card and transaction data, then send card data to issuer bank for confirm.

Bellow will illustrate expected key files and format for production by factory 
```
### 1.Production – key exchange Stage
```
Before massive production, Customer will be required to send bellow keys to DSPREAD for device initial keys. 
Let’s say production 1000 device on 2017/02/27. so POSID: xxxxxxxxx17022700001~1000
a)Customers send customer public key (PEM format) and IPEK key files to vendor
```


NO | Field        | Length       | Description
--------|---------------|------------|----------------
1     | KSN   | 14 | This is first 14 digits of KSN that related to last 14 digits of POSID
2     | Field separator  |1 | Comma “’, ” as field separator
3     | IPEK   | 32 | Encrypted IPEK under transmission key
4     | Field separator  | 1 | Comma “’, ” as field separator
5     | KCV  | 160 | IPEK key check value

IPEK.txt  template
```
xxx17022700001,AF8167638F879DF76E576E69AACFCE1E,5AA690, 76E576E69AACF EE9
xxx17022700002,F25451C5B3BD929B00BEE907B3F9EBC3,388D18, B3BD929B00BEE9AC
xxx17022700003,403E5A3E174DA57C571F4C5FCACBC7D9,C2919B,74DA57C571F4C5FC
xxx17022700004,1121978EFBEA242DC003FABBD52097E0,377B90, BEA242DC003FABBD
```
```
First Column: KSN 1(4 hexadecimal)
Second Column: encrypted IPEK under transmission key (32 hexadecimal)
Third Column: IPEK key check value
```
~~~javascript
Vendor will load the customer public key and IPEK into devices while manufacture. The public key will be used to verify customer authentication when update customer own keys.
~~~

NO | Field        | Length       | Description
--------|---------------|------------|----------------
1     | POS ID   | 20 | POS ID corresponding to each device public key
2     | Field separator  |1 | Comma “’, ” as field separator
3     | PSAM ID   | 8 | Device PCB ID
4     | Field separator  | 1 | Comma “’, ” as field separator
5     | Public key  | 256 | Each device public key 

pubkey.csv  template
```
xxxxxxxxx17022700001,71102301, BB8ECD444E8771F91DA1680433F303BFD5571A048E4DBDE73C95A5…
xxxxxxxxx17022700002,71102301,9615E170F3221DBC7D2C34210323067CFE5616BBFF0CE83C4798B76…
xxxxxxxxx17022700003,71102301,BC654B87AD4D9B1A9889E6679B5DC8F261F39D2100405159392E…
xxxxxxxxx17022700004,71102301,6EE02F924178198AA6D0DC6DA6055CD554F2FBF92D88393606A3C0…
First Column: pos id(20 difits) second column: public key
```
Device public key is used to encrypt the keys when customer update their own keys so that device can decrypt with its inside device private key to verify the terminal authentication.
```
Additional:
so Customer need send the specific production keys to us before production. For TRM management, we will provide each device public rsa key and api so that customers can manage their device remotely with digital envelope.
Digital envelope is achieved under the condition that both terminal vendor and terminal customer possess one pair of RSA key: private key and public key. Private key must be kept secret on HSM and never be sharable. And public key will be exchanged between vendor and customer for digital envelope dual authentication while customer RKI(remote key injection) management , Please refer to specific implementation steps bellow.
```

### 2.Key update-RKI (Remote Key Injection)
```
While at production stage, customer and vendor will exchange each other public key. Because RSA key (private/public key) should be one pair and matched. So it will be used to authenticate each both party identify. After exchange, Device and customer will possess the other party public key, which make secure RKI feasible, the theory is illustrated as bellow.
```
```
1.APP request encryption key, server will use device public key to encrypt keys, then use client private key sign on it and return digital envelope to app
2.APP call pos.updateWorkKey(envelope) to inject it into device
3.Terminal use client public key to verify the signature and then decrypt the keys , if both successfully, then save keys into memory. RKI completed !

```

### Digital Envelope Source Code

Firstly, please download the source code by this link:
```
https://mega.nz/#!1UlXiSxA!bH95hFaBvR9w50rVx67rc0ZdmU91jNFWh6jp-mnmLAE
```
Then import this project into eclipse, there are only 2 main file to interact- DukptKeys.java: this file only contains dukpt keys and device public key Envelope.java: this file is used to implement digital envelope generation

<p> DukptKeys.java</p>

```java
public static String dukptGroup="00"; // indicate update specific index group keys // IPEK and KSN keys for dukpt
public static String trackipek public static String emvipek public static String pinipek
public static String trackksn
public static String emvksn
public static String pinksn
//IPEK should be encrypted under tmk for security, so above IPEK is not in plaintext public static String tmk ="5F8B2B8818966C5CD4CC393AF9FC7722"; //RSA_public_key is used to generate digital envelope
public static String RSA_public_key="84F5F1C1CF03D7A9FE7BBA5E8C276B......”
```
Add your own server private key into “keys” folder in the project, then reference it in Envelope.java
Envelope.java
//reference your private key in Envelope.java file
```java
senderRsa.loadPrivateKey(new FileInputStream("keys/rsa_private_pkcs8.pem"));
```

Finally, run envelope.java as java application, then you will get digital envelope , call android sdk pos.updateWorkKey(envelope) to inject keys into device

