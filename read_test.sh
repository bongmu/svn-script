#/bin/bash
echo_warring() {
	echo "$1"
read -p "(请输入y/n):" value #-p 用于给出提示符,value赋值一个变量。
case ${value} in
	y)
	echo "ok"
	;;
	n)
	echo "no"
	;;
	*)
	echo "please input yes/no"
	;;
esac
}
echo_warring "请确认无连接再执行"  #函数 传递第一个参数
