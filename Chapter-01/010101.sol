// SPDX-License-Identifier: MIT
//solidity需要声明SPDX开源协议，MIT协议是完全开源
pragma solidity ^0.8.20;
//此处为声明版本号^表示可以被这个版本以上的版本编译
contract HelloWorld {
    bool boolVar_1 = true;
    bool boolVar_2 = false;
    //solidity的bool类型取值不能像其他语言一样取非0整数表示true
    //取0表示false，必须取true和false
    uint8 unitVar = 25;
    //uint表示无符号整数类型，uint8表示只能取值在0-255
    //uint256表示取值为0-二的256次幂减一
    //一般都使用uint256，uint类型不能赋值负数
    int256 intVar = -1;
    //int类型可以赋值负数

    //一个字节byte = 8bit
    //bytes类型最大为bytes32
    bytes32 bytesVar = "Hello World";

    string strVar = "Hello World";
    //string类型在solidity中就是动态分配存储空间的bytes类型

    address addrVar = 0x8EdAAA10B26CC5D5D0836F479608A144305be1F6;
    //这是地址类型，该钱包地址为我的MetaMask学习钱包的地址
}