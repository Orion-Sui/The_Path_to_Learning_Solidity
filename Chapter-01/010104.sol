// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
solidity中的数据存储模式:
1. storage
2. memory
3. calldata
4. stack
5. codes
6. logs

数据存储模式只对数据结构有效，像uint/bytes/int这类不需要声明数据存储模式

solidity中的存储分为永久性存储和暂时性存储，在前三种中
永久性存储：第一种storage
永久性存储：无论何时何地我去访问这个变量都会拿到那个赋的值，除非修改那个值
           永久的存储到区块链上了，永久的存储到了这个合约里
暂时性存储：第二种memory  第三种calldata
暂时性存储：只在当前这个交易运行时可以拿到这个值，这个操作结束后这个值就消失了
           我们以后无法去获取这个变量的值

memory和calldata的区别：memory类型的变量在运行时可以修改，calldata类型的变量在运行时不可以修改
                       例如calldata类型的变量在函数体中无法赋值修改，会报错
                       memory类型的变量在函数体中可以赋值修改，不会报错

在合约中声明的变量，而不是在函数声明的变量，是永久性的存储，理论上是storage类型，而且不需要声明

memory和calldata一般用在函数的入参，需要修改就用memory，不需要修改就用calldata

*/