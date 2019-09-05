#!/bin/bash
BUFSIZE=`expr 8 \* 1024 \* 1024`
sudo modprobe -i udmabuf udmabuf0=$BUFSIZE udmabuf1=$BUFSIZE udmabuf2=$BUFSIZE udmabuf3=$BUFSIZE udmabuf4=$BUFSIZE udmabuf5=$BUFSIZE udmabuf6=$BUFSIZE udmabuf7=$BUFSIZE

