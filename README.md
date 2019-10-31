<a href="https://www.sparkpost.com"><img src="https://www.sparkpost.com/sites/default/files/attachments/SparkPost_Logo_2-Color_Gray-Orange_RGB.svg" width="200px"/></a>

[Sign up](https://app.sparkpost.com/join?plan=free-0817?src=Social%20Media&sfdcid=70160000000pqBb&pc=GitHubSignUp&utm_source=github&utm_medium=social-media&utm_campaign=github&utm_content=sign-up) for a SparkPost account and visit our [Developer Hub](https://developers.sparkpost.com) for even more content.

# sparkyMomoTracking

A basic demo configuration for Momentum 4.x with SparkPost Signals.
Accompanies the SparkPost [blog series](https://www.sparkpost.com/blog/deploy-sparkpost-signals-for-on-premises-part-1/).

Standard files installed by Momentum and by Signals Agent are generally not shown here.

## Configuration tips

### Check server is supporting only TLS v1.1 and later

The following TLS v1.0 attempt should NOT display the peer certificate
```bash
openssl s_client -connect momo.signalsdemo.trymsys.net:587 -starttls smtp -tls1
```

Whereas TLS v1.1 (and v1.2) should succeed, displaying the peer certificate

```bash
openssl s_client -connect momo.signalsdemo.trymsys.net:587 -starttls smtp -tls1_1
```

gives
```
CONNECTED(00000005)
depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root CA
verify return:1
depth=1 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = RapidSSL RSA CA 2018
verify return:1
depth=0 CN = *.trymsys.net
verify return:1
---
Certificate chain
 0 s:/CN=*.trymsys.net
   i:/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=RapidSSL RSA CA 2018
 1 s:/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=RapidSSL RSA CA 2018
   i:/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert Global Root CA
---
Server certificate
-----BEGIN CERTIFICATE-----
:
:
```

### Checking Return-Path (bounce domain) and FBL ports

Check MX record is set up
```
dig MX +short momo.signalsdemo.trymsys.net
```
gives
```
10 momo.signalsdemo.trymsys.net.
```
Check
```
host momo.signalsdemo.trymsys.net
```
gives something like
```
momo.signalsdemo.trymsys.net has address 34.211.7.3
momo.signalsdemo.trymsys.net mail is handled by 10 momo.signalsdemo.trymsys.net.
```

Check that port 25 is open and ready to accept bounces:

```
telnet momo.signalsdemo.trymsys.net 25
```
gives
```
Trying 34.211.7.3...
Connected to momo.signalsdemo.trymsys.net.
Escape character is '^]'.
220 2.0.0 ip-172-31-22-249.us-west-2.compute.internal ESMTP ecelerity 4.3.0.67725 r(Core:4.3.0.0) Thu, 31 Oct 2019 20:22:27 +0000
```

Repeat the same tests for your FBL domain e.g. `fbl.momo.signalsdemo.trymsys.net`.
