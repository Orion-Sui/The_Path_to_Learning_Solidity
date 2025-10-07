// SPDX-License-Identifier: MIT
//solidity需要声明SPDX开源协议，MIT协议是完全开源
pragma solidity ^0.8.20;
//此处为声明版本号^表示可以被这个版本以上的版本编译
contract HelloWorld {
    string strVar = "Hello World";

    function sayHello() public view returns(string memory){
        return addinfo(strVar);//这里使用了后面的addinfo函数
    }  
    //可见度标识符可以限制函数可读取或者可调用的范围
    //可见度标识符表格
    //Visibility    Within contract     Outside contract    Child contract    External accounts
    //Public        Y                   Y                   Y                 Y
    //Private       Y                   N                   N                 N
    //Internal      Y                   N                   Y                 N
    //External      N                   Y                   N                 Y

    //view关键字表示我在这个函数里只会对变量进行读取
    //而不会对状态进行修改

    function setHelloWorld(string memory newString) public {
        strVar = newString;
    }
    //该函数是修改strVar变量的函数
    //因为这里要修改变量所以不能使用只读的view关键字
    //该函数也不需要返回值所以也不用returns
    //这个函数需要传入一个string类型的参量newString
    //到这里这个合约完成部署后直接sayHello还是显示原值，调用set函数后可以传入“你好世界”，再次调用say函数就可以显示“你好世界”了

    function addinfo(string memory HelloWorldStr) internal pure returns(string memory) {
       return string.concat(HelloWorldStr," from Orion's contract");    
    } 
    //到这里的目标是完成调用say函数时候修改strVar，并在后面加上from Orion的叙述
    //而且在修改strVar变量后再次调用say函数依旧显示

    // pure关键字类似view关键字表示我在这个函数里只会对变量进行运算，不会对状态进行修改

    // 这里用到了string的concat方法，对字符串进行连接

    //【2025.10.7更新】view和pure的区别
    // 来源：https://blog.csdn.net/zyq55917/article/details/124428142
    // Solidity 语言有两类和状态读写有关的函数类型，一类是 view 函数（也称为视图函数），另一类是 pure 函数（也称为纯函数）
    // 他们的区别是 view 函数不修改状态，pure 函数即不修改状态也不读取状态
    // 下面的语句被认为是在修改状态：
    /* 1.修改状态变量；
       2.触发事件；
       3.创建其他合约；
       4.使用 selfdestruct；
       5.通过调用发送以太币；
       6.调用任何未标记 view 或 pure 的函数；
       7.使用低级调用；
       8.使用包含某些操作码的内联汇编。*/
    // 下面的语句被认为是读取状态的：
    /* 1.从状态变量中读取；
       2.访问 address(this).balance 或 address.balance；
       3.访问 block, tx, msg 的任何成员(除了 msg.sig 和 msg.data)；
       4.调用任何未标记为 pure 的函数；
       5.使用包含某些操作码的内联汇编。*/
    // 个人见解：view > pure 即pure要求更为严格
    // 经过测试此处addinfo，从pure改成view会报黄色警告，但代码仍能运行
    // 而众筹合约的view函数改为pure则会报红色警告，代码无法运行

}
