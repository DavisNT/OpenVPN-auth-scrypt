OpenVPN-auth-scrypt
===============
Authentication (`--auth-user-pass-verify`) [Perl](https://www.perl.org/) script 
for [OpenVPN](https://openvpn.net/) that takes usernames and 
[scrypt](https://en.wikipedia.org/wiki/Scrypt) 
encrypted/hashed passwords from a text file.

Copyright (c) 2018-2019 Davis Mosenkovs

## Introduction

...

## Usage

After setting up and configuring OpenVPN-auth-scrypt access can be managed by 
editing the text file with usernames and hashed passwords (VPN passwords file) 
in addition to certificates. For a user to be able to access VPN both a valid 
certificate and entry in VPN passwords file are required. Common name of the 
certificate must match username in VPN passwords file. To add a new entry to 
the file password hash must be generated by HTML form (`hashcalc.html`). The 
HTML form will display the line to be added to VPN passwords file. Hash also 
depends on the username provided (and on many of the settings configurable in 
`hashcalc.html` and `verify.pl`). Usernames are case insensitive.

## Setup and configuration

...

## Notices

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## 3rd party libraries used

The HTML form for generating hashes (`hashcalc.html`) contains the following 
3rd party JavaScript libraries bundled:

* [scrypt-js](https://github.com/ricmoo/scrypt-js)
* [setImmediate](https://github.com/YuzuJS/setImmediate)

The Perl script for verification of the usernames/passwords/hashes (`verify.pl`) 
uses the following Perl module (that needs to be installed on OpenVPN server):

* [Crypt::ScryptKDF](https://metacpan.org/pod/Crypt::ScryptKDF)
