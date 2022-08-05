## 


## java.endorsed.dirs的作用

### java提供了endorsed技术：
    
    关于endorsed：可以的简单理解为-Djava.endorsed.dirs指定的目录面放置的jar文件，
    将有覆盖系统API的功能。可以牵强的理解为，将自己修改后的API打入到JVM指定的启动API中，取而代之。
    但是能够覆盖的类是有限制的，其中不包括java.lang包中的类。
    比如Java的原生api不能满足需求，假设我们需要修改 ArrayList 类，
    由于我们的代码都是基于ArrayList做的，那么就必需用到 Java endorsed 技术，
    将我们自己的ArrayList，注意包和类名和java自带的都是一样的，打包成一个jar包，
    放入到-Djava.endorsed.dirs指定的目录中，
    这样我们在使用java的ArrayList的时候就会调用的我们定制的代码

---
    根据官方文档描述：如果不想添加-D参数，如果我们希望基于这个JDK下的都统一改变，
    那么我们可以将我们修改的jar放到：

`$JAVA_HOME/jre/lib/endorsed`

    这样基于这个JDK的所有的ArrayList都变了

#### 注意：
    1. 能够覆盖的类是有限制的，其中不包括java.lang包中的类,比如java.lang.String这种 就不行
    2. endorsed目录：.[jdk安装目录]./jre/lib/endorsed，不是jdk/lib/endorsed，目录中放的是Jar包，
       不是.java或.class文件，哪怕只重写了一个类也要打包成jar包
    3. 可以在dos模式查看修改后的效果(javac、java)，
       在eclipse需要将运行选项中的JRE栏设置为jre(若设置为jdk将看不到效果)。
    4. 重写的类必须满足jdk中的规范，例如：自定义的ArrayList类也必须实现List等接口。
    5. System.out.println(System.getProperty("java.endorsed.dirs"));
