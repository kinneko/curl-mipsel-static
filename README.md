curl-mipsel-static
==================

Script to create static curl binary for mipsel devices using the entware toolchain.

Make sure the entware toolchain is already in your PATH, and run.

The resulting binaries are available at http://lancethepants.com/files

update for qemu-mipsel (kinneko)

https://people.debian.org/~aurel32/qemu/mipsel/debian_wheezy_mipsel_standard.qcow2

https://people.debian.org/~aurel32/qemu/mipsel/vmlinux-3.2.0-4-4kc-malta

AWS IoTをRESTでしゃべらせるために、mipselなカメラに突っ込むcurlのスタティックバイナリがほしかったので、既存のビルドスクリプトに手を加えて使用しました。

mipselをcrossでやってみましたが、バイナリはできるものの、どうも動作がうまくいかないので、qemu上でビルドしてみました。作業はとても遅いです。

動作試験環境は、Intel Atom D510(1.66GHz), RAM2GBに、Ubuntu 17.04をインストールし、上記の既存のdebian用のmipselイメージを起動しました。

ターゲットがuClibcを使っている場合は、レゾルバ関数がglibcと違うので名前引きできません。

~~~~
# ./curl www.google.com
curl: (6) Couldn't resolve host 'www.google.com'
# ./curl --dns-servers 8.8.8.8 www.google.com
curl: (4) A requested feature, protocol or option was not found built-in in this libcurl due to a build-time decision.
# ./curl 216.58.197.4
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
~~~~
