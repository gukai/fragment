#!/bin/sh
#FIXME: 
    创建秘钥的操作：ssh-keygen -q <-t type>  <-N "">  <-C comment> <-f keypath>
    使用私钥：修改权限600，ssh -i prikey usr@hostname
#attach 命令要求同时传递pubkey串，从而将公钥attach到当前主机上.
#detach 命令要求同时传递comment内容，从而将以此为依据将公钥从认证文件中删除.


KeyDir="/root/.ssh/"
PKeyPath="/root/.ssh/authorized_keys"
PUBKEY=""
COMMENT=""


detach(){

    if [ ! -e $PKeyPath ]; then
        echo "authorized_keys is not exist."
        exit 0
    fi

    local comment=$1
    local cmd="sed -i '/${comment}$/d' ${PKeyPath}"
    eval $cmd       
}

attach(){
    local pubkeystr=$1
    #echo $pubkeystr

    if [ ! -d $KeyDir ]; then
        mkdir -p $KeyDir
        chmod 700 $KeyDir
    fi

    if [ ! -e $PKeyPath ]; then
        touch $PKeyPath
        chmod 600 $PKeyPath
    fi
  
   echo $pubkeystr >> $PKeyPath
}

VerfiyParameter(){
    local liststr=$1
    #echo $liststr
    local paralist=$(printf %s "$liststr" |tr ' ' '\n')

    for paraname in $paralist; do
        eval paravalue="$"$paraname
        #echo $paraname is $paravalue
        if [ -z "$paravalue" ]; then
            echo $paraname
            return 1
        fi
    done

    return 0
}



#dattach "$1"

TEMP=`getopt -o m:c:t: --long command:,pubkey:,comment: \
     -n 'ERROR' -- "$@"`

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$TEMP"

while true ; do
        case "$1" in
                -m| --command) COMMAND=$2 ; shift 2 ;;
                -c|--pubkey) PUBKEY=$2; shift 2 ;;
                -t|--comment) COMMENT=$2; shift 2 ;;
                --) shift ; break ;;
                *) echo "Unknow Option, verfiy your command" ; usage; exit 1 ;;
        esac
done

if [ -z "${COMMAND}" ];then
    echo "COMMAND IS NULL"
    exit 1
fi

case $COMMAND in
    attach)
        if ! ret=`VerfiyParameter "PUBKEY"`; then
              echo "PUBKEY not set"
              exit 1
        fi 
        attach "$PUBKEY" 
        ;;
    detach) 
       if ! ret=`VerfiyParameter "COMMENT"`; then
              echo "COMMENT not set"
              exit 1
       fi
       detach $COMMENT  
       ;;
    *)
       echo $"Usage: $0 {start|stop|restart|condrestart|status}"
       exit 2
       ;;
esac


