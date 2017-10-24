#/bin/bash
echo_error() {    echo -ne "\033[31;1m $1\033[0m\n";}
echo_ok() {    echo -ne "\033[32;1m $1\033[0m\n";}
echo_warn() {    echo -ne "\033[33;1m $1\033[0m\n";}
usage(){
        cat <<EOF
`echo_error 使用说明:`
	sh $0 code_to_svnpath  #将网站代码更新到工作目录
        sh $0 username to_svn #将更新的文件更新到svn
EOF
        exit 1
}


[ ! -d /code/wordpress ] && mkdir -p /code/wordpress && svn co http://svn.${svn_name}.top/sh/wordpress/ /code/wordpress && exit 1  || cd /code/wordpress #检查有没有创建工作目录
cd /code/wordpress  #进入到工作目录
update_svn()
{
	svn  update --username ${svn_name}	
	if [ $? -ne 0 ];then
		echo  "svn update failed" 
		exit 1
	fi
	VERSION=`svn info |awk -F"[ ]+" '/Revision/{print $2}'`
	TEMP="`date +%Y%m%d`${VERSION}"
	NUM=`echo ${TEMP}+1|bc`
	echo -e "####################\nsvn update complete"
}

svn_commit ()
{
VERSION=`svn info |awk -F"[ ]+" '/Revision/{print $2}'`
	echo "cd /code/wordpress"
	cd /code/wordpress
	[ ! -d /root/shell_log ] && mkdir -p /root/shell_log
	mkdir -p /root/shell_log/${VERSION} 
	svn status |awk '{if($1=="!") print $0}' |cut -b 9- >/root/shell_log/${VERSION}/svn_del.log
	svn status |awk '{if($1=="?") print $0}' |cut -b 9- >/root/shell_log/${VERSION}/svn_add.log
	svn status |awk '{if($1=="M") print $0}' |cut -b 9- >/root/shell_log/${VERSION}/svn_change.log
	while read line ;do svn delete "$line" ;done </root/shell_log/${VERSION}/svn_del.log  && echo "svn delete complete"
	while read line ;do svn add "$line" ;done </root/shell_log/${VERSION}/svn_add.log   &&  echo "svn add complete"
	svn commit -m "`date +%Y%m%d%H%M%S`" --username ${svn_name} && echo "svn commit complete"
	#删除认证文件
	rm -f /root/.subversion/auth/svn.simple/*
}

##判断位置参数
if [ $# -eq 0 ] ; then 
	usage
fi

##判断是否是一个参数即：如果第二个参数为空。。。
if [ -z "$2" ]  ; then 
	case $1 in 
code_to_svnpath)
	/usr/bin/rsync  -avz --delete --exclude=".svn" /var/www/html/wordpress/ /code/wordpress 
	;;
*)
	usage
	;;
esac
fi

###判断是否为两个参数即：如果是两个参数则。。。
if [ -n "$2" ] ; then 
	svn_name=$1
	case $2 in 
to_svn)
	update_svn
	/usr/bin/rsync  -avz --delete --exclude=".svn" /var/www/html/wordpress/ /code/wordpress
	svn_commit
	;;
*)
	usage
	;;
	esac	

fi
