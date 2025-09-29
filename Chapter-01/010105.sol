// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//solidity中不同的数据结构，使用数组来完成需求

//struct： 结构体（把多个数据类型存储在一个数据结构中）
//array：  数组
//mapping：映射（存储的是键值对）

//这个案例实现的功能是根据不同的标识（id）在不同调用人调用say函数时返回不同的值
//并且有设置不同标识（id）对应不同的值的功能

contract HelloWorld{
    //预先设置一个结构体，因为不同的短语由不同的人提交，需要多个元素拼凑起来
    struct Info{
        string phrase; //这里就是每个人不同的短语的变量
        uint256 id;    //这里就是标识（id）变量
        address addr;  //这是是需要知道谁去创建了这个短语，存他的地址的变量
    }

    Info[] infos; //声明一个Info结构体的数组起名infos

    string strVar = "Hello World"; //这里是默认值

    //在setHelloWorld函数中通过输入信息把短语、id、由谁创建(地址)，存储起来
    function setHelloWorld(string memory newString, uint256 _Id) public {
        //这里uint256没加memory是因为uint是基础数据类型不用加
        
        //创建一个结构体他的数据类型为Info类，并指明数据存储模式为memory
        //并取名为info变量
        //solidity中类型或者合约一般为大写开头，变量一般为小写开头
        Info memory info = Info(newString, _Id, msg.sender);
        //此处顺序对应设置结构体时参数的顺序
        //获取地址就不用入参了，因为solidity中有一个环境变量msg可用
        //msg.sender ：获取调用当前合约这笔交易的发起者的地址
        //msg.value  ：获取当前这笔交易中包含的Ethereum的数量
        
        infos.push(info);
        //把收集到的info用push方法加入到infos数组中
        //此处就将memory的info变为storage的数组永远储存在区块链
    }

    function say(uint256 _id) public view returns(string memory){
        //用户需要告诉我们他想要调用哪个id的结构体，所以这个say函数需要一个传入参数_id

        //用for循环来遍历数组查找我们想要的元素
        //for函数的第一个值是当前查询的值，第二个是终止循环的条件，第三个是变化（跟python一样）
        for(uint256 i = 0; i < infos.length; i++){
        //从第0个值开始逐个查找，当i小于数组长度停止
            if(infos[i].id == _id){
            //infos数组中的第i号元素就是一个结构体,取id判断是否等于用户输入的_id
                return addinfo(infos[i].phrase);
                //这里使用了后面的addinfo函数
                //当id相等时就返回这个元素的短语    
            }
        }
        return addinfo(strVar);
        //这里使用了后面的addinfo函数
        //当遍历了所有元素依然没有找到时就返回默认值
    }
    
    function addinfo(string memory HelloWorldStr) internal pure returns(string memory) {
       return string.concat(HelloWorldStr," from Orion's contract");    
        //到这里的目标是完成调用say函数时候修改strVar，并在后面加上from Orion的叙述
        //而且在修改strVar变量后再次调用say函数依旧显示
        //这里用到了string的concat方法，对字符串进行连接
 
    }
    

}