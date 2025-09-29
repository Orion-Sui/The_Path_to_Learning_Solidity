// SPDX-License-Identifier: MIT
//solidity需要声明SPDX开源协议，MIT协议是完全开源
pragma solidity ^0.8.20;
//此处为声明版本号^表示可以被这个版本以上的版本编译
contract HelloWorld {
    string strVar = "Hello World";
    //string类型在solidity中就是动态分配存储空间的bytes类型

    function sayHello() public view returns(string memory){
        return strVar;
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

    //returns(string memory)  表示函数会给出string类型的返回值

    function setHelloWorld(string memory newString) public {
        strVar = newString;
    }
    //该函数是修改strVar变量的函数
    //因为这里要修改变量所以不能使用只读的view关键字
    //该函数也不需要返回值所以也不用returns
    //这个函数需要传入一个string类型的参量newString
    //到这里这个合约完成部署后直接sayHello还是显示原值，调用set函数后可以传入“你好世界”，再次调用say函数就可以显示“你好世界”了
}