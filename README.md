## Page Contents
- [Introduction](#introduction)
- [Features](#features)
- [Supported Platforms](#supported-platforms)
- [Synopsis](#synopsis)
- [Downloading](#downloading)
- [Compiling](#compiling)
- [Examples](#examples)
  - [Show SMTP server information](#show-smtp-server-information)
    - [StartTLS will be used if server supports it](#starttls-will-be-used-if-server-supports-it)
    - [Use SSL. Note the port is different](#use-ssl-note-the-port-is-different)
  - [Send mail with a text message](#send-mail-with-a-text-message)
  - [Send mail with a HTML message](#send-mail-with-a-html-message)
  - [Attach a PDF file](#attach-a-pdf-file)
  - [Attach a PDF file and an image](#attach-a-pdf-file-and-an-image)
  - [Attach a PDF file and embed an image](#attach-a-pdf-file-and-embed-an-image)
  - [Set Sender and Recipient's name](#set-sender-and-recipients-name)
  - [Set Carbon Copy and Blind Carbon copy](#set-carbon-copy-and-blind-carbon-copy)
  - [Send mail to a list of users](#send-mail-to-a-list-of-users)
  - [Add Custom Headers](#add-custom-headers)
- [License (is MIT)](#license-is-mit)
- [See Also](#see-also)

# Introduction

`mailsend-go` is a command line tool to send mail via SMTP protocol. This is the
[golang](https://golang.org/) incarnation of my C version of
[mailsend](https://github.com/muquit/mailsend/). However, this version is much
simpler and all the heavy lifting is done by the package
[gomail.v2](https://gopkg.in/gomail.v2)

If you use [mailsend](https://github.com/muquit/mailsend), please consider
using mailsend-go as no new features will be added to 
[mailsend](https://github.com/muquit/mailsend).

If you have any question, request or suggestion, please enter it in the 
[Issues](https://github.com/muquit/mailsend-go/issues) with appropriate label.

# Features

* Add mail body
* Multiple Attachments
* ESMTP Authentication
* Supports StartTLS and SSL
* Send mail to a list of users
* Show SMTP server info
* Fixes [issues of mailsend](https://github.com/muquit/mailsend#known-issues)

# Supported Platforms

It is written in [go](https://golang.org/), therefore, it can be compiled
in many platforms verify easily. The compiled bianries for the following 
platforms are supplied:

* Linux
* Windows
* MacOS

Please add an issue if you would need binaries for any other platforms.

# Synopsis
```
 Version: @($) mailsend-go v1.0.1

 mailsend-go [options]
  Where the options are:
  -debug                 - Print debug messages
  -sub subject           - Subject
  -tname                 - name of recipient
  -t to,to..*            - email adderss/es of the recipient/s. Required
  -list file             - file with list of email addresses. 
                           Syntax is: Name, email_address
  -fname name            - name of sender
  -f address*            - email address of the sender. Required
  -cc cc,cc..            - carbon copy addresses
  -bcc bcc,bcc..         - blind carbon copy addersses
  -smtp host/IP*         - hostname/IP address of the SMTP server. Required
  -port port             - port of SMTP server. Default is 587
  -domain domain         - domain name for SMTP HELO. Default is localhost
  -info                  - Print info about SMTP server
  -ssl                   - SMTP over SSL. Default is StartTLS
  -verifyCert            - Verify Certificate in connection. Default is No
  auth                   - Auth Command
    -user username*      - username for ESMTP authentication. Required
    -pass password*      - password for EMSPTP autnentication. Required
  -ex                    - show examples
  -help                  - show this help
  -q                     - quiet
  -V                     - show version and exit
  body                   - body command for attachment for mail body
    -msg msg             - message to show as body 
    -file path           - or path of a text/HTML file
    -mime-type type      - MIME type of the body content. Default is detected
  attach                 - attach command. Repeat for multiple attachments
    -file path*          - path of the attachment. Required
    -name name           - name of the attachment. Default is filename
    -mime-type type      - MIME-Type of the attachment. Default is detected
    -inline              - Set Content-Dispotion to "inline". 
                           Default is "attachment"
  header                 - Header Command. Repeat for multiple headers
    -name header         - Header name
    -value value         - Header value

The options with * are required. 
Environment variables:
   SMTP_USER_PASS for auth password (-pass)
    
```

# Downloading

Pre-built `mailsend-go` binaries for Windows, Linux and MacOS can be
downloaded from the [releases](https://github.com/muquit/mailsend-go/releases)
page. However, binaries for other platforms can be cross-compied easily by setting
the [environment variables](https://golang.org/doc/install/source#environment) *GOOS* and *GOARCH*.

# Compiling

Compiling from scratch requires the [Go programming language toolchain](https://golang.org/dl/) and git.

To download, build and install (or upgrade) mailsend-go, run:

```
go get -u github.com/muquit/mailsend-go
```
If you see the error message `go: cannot find main module; see 'go help
modules'`, make sure GO111MODULE env variable is not set to on. Unset it by
typing `unset $GO111MODULE`.


To compile yourself:

* If you are using very old version of go, install dependecies by typing:

```
make tools
make
```

* If you are using go 1.11+, dependencies will be installed via go modules.
If you cloned mailsend-go inside your $GOPATH, you have to set env var:

```
export GO111MODULE=on
```
* Finally compile mailsend-go by typing:

```
make
```

Type `make help` for more targets:


# Examples

Each example mailsend-go command is a single line. In Unix back slash \ 
can be used to continue in the next line. Also in Unix, use single quotes 
instead of double quotes, otherwise if input has any shell character like 
$ etc, it will get expanded by the shell.

## Show SMTP server information

### StartTLS will be used if server supports it

```
  mailsend-go -info -smtp smtp.gmail.com -port 587
```    

```
[S] 220 smtp.gmail.com ESMTP k185-v6sm17739711qkd.27 - gsmtp
[C] HELO localhost
[C] EHLO localhost
[S] 250-smtp.gmail.com at your service, [x.x.x.x]
[S] 250-SIZE 35882577
[S] 250-8BITMIME
[S] 250-STARTTLS
[S] 250-ENHANCEDSTATUSCODES
[S] 250-PIPELINING
[S] 250-CHUNKING
[S] 250-SMTPUTF8
[C] STARTTLS
[S] 220-2.0.0 Ready to start TLS
[C] EHLO localhost
[S] 250-smtp.gmail.com at your service, [x.x.x.x]
[S] 250-SIZE 35882577
[S] 250-8BITMIME
[S] 250-AUTH LOGIN PLAIN XOAUTH2 PLAIN-CLIENTTOKEN OAUTHBEARER XOAUTH
[S] 250-ENHANCEDSTATUSCODES
[S] 250-PIPELINING
[S] 250-CHUNKING
[S] 250-SMTPUTF8
Certificate of smtp.gmail.com:
 Version: 3 (0x3)
 Serial Number: 149685795415515161014990164765 (0x1e3a9301cfc7206383f9a531d)
 Signature Algorithm: SHA256-RSA
 Subject: CN=Google Internet Authority G3,O=Google Trust Services,C=US
 Issuer: GlobalSign
 Not before: 2017-06-15 00:00:42 +0000 UTC
 Not after: 2021-12-15 00:00:42 +0000 UTC
[C] QUIT
[S] 221-2.0.0 closing connection k185-v6sm17739711qkd.27 - gsmtp
```

### Use SSL. Note the port is different

```
  mailsend-go -info -smtp smtp.gmail.com -port 465 -ssl
```

## Send mail with a text message

Notice "auth" is a command and it takes -user and -pass arguments. "body" is
also a command and here it took -msg as an argument. The command "body" can
not repeat, if specified more than once, the last one will be used.

```
    mailsend-go -sub "Test"  -smtp smtp.gmail.com -port 587 \
     auth \
      -user jsnow@gmail.com -pass "secret" \
     -from "jsnow@gmail.com" -to  "mjane@example.com" \
     body \
       -msg "hello, world!"
```                    
The environament variable "SMTP_USER_PASS" can be used instead of the flag
`-pass`.

## Send mail with a HTML message
```
    mailsend-go -sub "Test"  \
    -smtp smtp.gmail.com -port 587 \
    auth \
     -user jsnow@gmail.com -pass "secret" \
    -from "jsnow@gmail.com"  \
    -to  "mjane@example.com" -from "jsnow@gmail.com" \
    body \
     -msg "<b>hello, world!</b>"
```

## Attach a PDF file
MIME type will be detected. Content-Disposition will be set to "attchment",
Content-Transfer-Encoding will be "Base64". Notice, "attach" is a command it
took -file as an arg. The command "attach" can repeat.
```
    mailsend-go -sub "Test"  \
    -smtp smtp.gmail.com -port 587 \
    auth \
     -user jsnow@gmail.com -pass "secret" \
    -from "jsnow@gmail.com"  \
    -to  "mjane@example.com" -from "jsnow@gmail.com" \
    body \
     -msg "A PDF file is attached" \
    attach \
     -file "/path/file.pdf"

```
## Attach a PDF file and an image
Notice, the "attach" command is repeated here.
```
    mailsend-go -sub "Test"  \
    -smtp smtp.gmail.com -port 587 \
    auth \
     -user jsnow@gmail.com -pass "secret" \
    -from "jsnow@gmail.com"  \
    -to  "mjane@example.com" -from "jsnow@gmail.com" \
    body \
     -msg "A PDF file and a PNG file is attached" \
    attach \
     -file "/path/file.pdf" \
    attach \
     -file "/path/file.png"
```
## Attach a PDF file and embed an image
Content-Dispositon for the image will be set to "inline". It's an hint to the
mail redear to display the image on the page. Note: it is just a hint, it is
up to the mail reader to respect it or ignore it.
```
    mailsend-go -sub "Test"  \
    -smtp smtp.gmail.com -port 587 \
    auth \
     -user jsnow@gmail.com -pass "secret" \
    -from "jsnow@gmail.com"  \
    -to  "mjane@example.com" -from "jsnow@gmail.com" \
    body \
     -msg "A PDF file is attached, image should be displayed inline" \
    attach \
     -file "/path/file.pdf" \
    attach \
     -file "/path/file.png" \
     -inline
```
## Set Sender and Recipient's name
```
    mailsend-go -sub "Testing -fname and -tname"  \
    -smtp smtp.gmail.com -port 587 \
    auth \
     -user example@gmail.com -pass "secret" \
     -to jsoe@example.com \
     -tname "John Soe" \
     -fname "Example Foo" \
     -f "example@gmail.com" \
     body -msg "Testing Recipient and Sender's name"
```
## Set Carbon Copy and Blind Carbon copy
```
    mailsend-go -sub "Testing -cc and -bcc" \
    -smtp smtp.gmail.com -port 587 \
    auth \
     -user example@gmail.com -pass "secret" \
     -to jsoe@example.com \
     -f "example@gmail.com" \
     -cc "user1@example.com,user2@example.com" \
     -bcc "foo@example.com" \
     body -msg "Testing Carbon Copy and Blind Carbon copy"
```
Cc addresses will be visible to the recipients but Bcc address will not be.

## Send mail to a list of users

Create a file with list of users. The syntax is ```Name,email_address``` in a line. Name can be empty but comma must be specified. Example of a list file:

```
John Snow,jsnow@example.com
Mary Jane,mjane@example.com
,foobar@example.com
```

Specify the list file with ```-list``` flag. 

```
    mailsend-go -sub "Test sending mail to a list of users" \
    -smtp smtp.gmail.com -port 587 \
    auth \
     -user example@gmail.com -pass "secret" \
        -f "me@example.com" \
        -to "xyz@example.com" \
        body \
        -msg "This is a test of sendmail mail to a list of users" \
        attach \
            -file "cat.jpg" \
         attach \
            -file "flower.jpg" \
            -inline \
         -list "list.txt"
```

## Add Custom Headers

Use the command "header" to add custom headers. The command "header" can be
repeated.

```
    mailsend-go -sub "Testing custom headers" \
    -smtp smtp.gmail.com -port 587 \
    auth \
     -user example@gmail.com -pass "secret" \
     -to jsoe@example.com \
     -f "example@gmail.com" \
     body -msg "Testing adding Custom headers"
     header \
         -name "X-MyHeader-1" -value "Value of X-MyHeader-1" \
     header \
         -name "X-MyHeader-2" -value "Value of X-MyHeader-2"

```
---

(Generated from docs/examples.md)

---

# License (is MIT)

License is MIT

Copyright © 2018-2019 muquit@muquit.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# See Also

Original [mailsend](https://github.com/muquit/mailsend) (in C)

---
This README.md is assembled with [markdown_helper](https://github.com/BurdetteLamar/markdown_helper)
