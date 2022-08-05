echo %java_home%
rem 保存当前目录
set "CURRENT_DIR=%~dp0"

rem  第一步：
rem			遍历 jdk源码中 java.包部分源码，生成Java文件清单
rem			文件夹 src来自于%java_home%\src.zip
dir /B /S /X src\java\*.java > java_file_list.txt



rem 第二步：
rem			复制编译需要的rt.jar 到当前目录
copy "%java_home%\jre\lib\rt.jar" %~dp0rt.jar"

rem  第三步：
rem			如果不存在debug文件夹，就创建
if not exist "debug" md "debug"
rem			使用javac 编译文件清单(java_file_list.txt)里的类，生成字节码文件
rem			输出日志存在 log.txt
javac -encoding utf-8 -J-Xms16m -J-Xmx1024m -sourcepath src\java -cp rt.jar -d debug -g @java_file_list.txt >> log.txt 2>&1


rem 第四步：
rem			进入编译后的debug目录，生成调试jar包
cd debug
jar cf0 rt_debug.jar *

rem 第五步:
rem			如果jre下不存在endorsed文件夹，就创建
if not exist "%java_home%\jre\lib\endorsed" md "%java_home%\jre\lib\endorsed"
rem			把调试jar包放置 %java_home% 下面
copy rt_debug.jar "%java_home%\jre\lib\endorsed\rt_debug.jar"


rem 第六步:
rem			清理文件 
rem			DOTO 删除文件要慎重
cd "%CURRENT_DIR%"


pause