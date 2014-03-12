#!/bin/sh


#检查全局变量列表中的值是否为空，通常用于检查参数列表中的值.
#echo the unset parameter name and return 1 if have some parameter unset.
VerfiyParameter(){
    local liststr=$1
    #echo $liststr
    local paralist=$(printf %s "$liststr" |tr ' ' '\n')

    for paraname in $paralist; do
        eval paravalue="$"$paraname
        #echo $paraname is $paravalue
        if [ -z $paravalue ]; then
            echo $paraname
            return 1
        fi
    done

    return 0
}
######Test########
#    if ! ret=`VerfiyParameter "$paralist"`; then
#        echo "ERROR"
#        echo "Parameter $ret is not set."
#        exit 1
#    fi
##################




