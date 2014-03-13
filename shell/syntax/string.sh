#!/bin/sh

#以特定标志为分界，截取字符串部分内容.
#利用cut命令，-d后面的确定了分割标志，-f2表示获取第二部分.
teststr="name=wuchenggao"
ret=`echo $teststr | cut -d'=' -f2`
echo $ret


