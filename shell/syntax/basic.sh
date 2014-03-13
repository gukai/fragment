#!/bin/sh


#是非判断daemon
#if <condition> ; then
#    do something
#elif <condition>; then
#    do something
#else
#    do something
#fi

if ! true; then
    echo "not ture"
elif false; then
    echo "false"
else
    echo "other"
fi


循环
while true; do
    echo "hello world"
done

