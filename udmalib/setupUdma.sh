#!/bin/bash
BUFSIZE=`expr 8 \* 1024 \* 1024`
cd "$(dirname "$0")"
sudo insmod ./udmabuf/udmabuf.ko udmabuf0=$BUFSIZE udmabuf1=$BUFSIZE udmabuf2=$BUFSIZE udmabuf3=$BUFSIZE udmabuf4=$BUFSIZE udmabuf5=$BUFSIZE udmabuf6=$BUFSIZE udmabuf7=$BUFSIZE

