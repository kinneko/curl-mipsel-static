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

