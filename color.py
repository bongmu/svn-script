#coding=utf-8
print("=====字体颜色======")
print("\033[1;31;48m 哈哈\033[0m")
print("\033[1;32;48m 哈哈\033[0m")
print("\033[1;33;48m 哈哈\033[0m")
print("\033[1;34;48m 哈哈\033[0m")
print("\033[1;35;48m 哈哈\033[0m")
print("\033[1;36;48m 哈哈\033[0m")
print("\033[1;37;48m 商品列表如下：\033[0m")

print("-----------------")

class color:
    def echo_error(self,red):
        print(f"\033[31;1m {red}\033[0m".strip())

    def echo_ok(self,green):
        print(f"\033[32;1m {green}\033[0m".strip())

    def echo_warn(self,warning):
        print(f"\033[33;1m {warning}\033[0m")

color = color()
color.echo_error("red")
color.echo_ok("green")



#定义日志输出函数
class UtilLogger:
    def __init__(self):
        self.__isInit = False

    def console(self, msg, color):
        """ log file for msg """
        if self.__isInit != True:
            return

    def msg(self, msg):
        """ log file for msg """
        if self.__isInit != True:
            return

g_logger = UtilLogger()

def logConsole(msg, color = "green"):
    g_logger.console(msg, color)
    g_logger.msg(msg)

logConsole("哈哈哈哈","blue")