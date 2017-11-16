#/bin/bash
#for语句循环步长默认是1 
for list in {1..5};do #中间用点号省略表示某个范围 
	echo "the number is $list"
done

for lists in {1,2,3,4,5};do   #也可以用都好写出范围
	echo "the number is $lists"
done

###定义变量
sum="0";
#for循环开始，设置起始数值到结束数值，步长为2 
for i in {1..100..2};do 
	let "sum+=i"
done 
echo "the sum is $sum"

#带c风格的for循环
#for ((i=2;i>=2;i++));do #((i=1;i<5;i++)) i赋值；i<5定义范围；i加1
#	echo "$i"
#done

#定义数组，通过for循环遍历数组元素
array=(Monday Tuesday Wendesday Thursday Friday Saturday Sunday)
for day in ${array[*]};do
	echo "${day}"
done

#条件省略，产生死循环,会一直循环下去
#for ((;;))
#do
#	echo "hello word"
#done

#批量创建目录
for((i=1;i<=254;i++));do 
mkdir -p /usr/local/photobak/192.168.7.$i
echo mkdir /usr/local/photobak/192.168.7.$i; 
done
