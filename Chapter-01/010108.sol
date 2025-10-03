// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//智能合约工厂模式——HelloWorld工厂合约
//工厂模式的想法是拥有一个合约工厂，该合约将承担创建其他合约的任务

//HelloWorld工厂合约：我作为一个项目方我提供一个HelloWorldFactory，
//用户就能使用这个工厂合约生成一个自己的HelloWorld

//第二种方法：引入网络上的合约，打开要调用文件的Github把URL复制过来
import { HelloWorld } from "https://github.com/Orion-Sui/The_Path_to_Learning_Solidity/blob/main/Chapter-01/010106.sol";
//但是要注意这里的Github库里的文件地址需要是Public状态或者自己账号可见的状态

contract HelloWorldFactory{

    HelloWorld hw;
    //一个文件中可以有多个合约，并且合约也可以作为一种数据类型    
    //我们在HelloWorldFactory合约中声明了一个HelloWorld类型的变量hw

    HelloWorld[] hws;
    //这里声明了一个HelloWorld类型的数组，名字叫hws

    //创建HelloWorld的函数
    function createHelloWorld() public {
        hw = new HelloWorld(); //创建HelloWorld合约
        hws.push(hw); //将创建的HelloWorld合约加入到数组中,压入的数组下标从0开始，也就是后面的_index参数
    }
    
    //读取HelloWorld的函数，读取出来的是合约的地址
    function getHelloWorldByIndex(uint256 _index) public view returns(HelloWorld){
        return hws[_index];
    }
    
    //通过一个函数调用另一个合约的say函数
    function callSayFromFactory(uint256 _index, uint256 _id) public view returns(string memory){
    //_index入参是为了找到合约，_id入参是因为HelloWorld合约中的say函数有一个_id的入参
    //returns是因为HelloWorld合约中的say函数有一个string memory的returns
        return hws[_index].say(_id);
        //通过一个合约调用另一个合约的say函数，实现了合约的互操作性
    }

    //通过一个函数调用另一个合约的setHelloWorld函数
    function callsetHelloWorldFromFactory(uint256 _index, string memory newString, uint256 _Id) public {
        hws[_index].setHelloWorld(newString, _Id);
    }
}    