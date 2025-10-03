// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//智能合约工厂模式及引用合约的三种方法
//工厂模式的想法是拥有一个合约工厂，该合约将承担创建其他合约的任务

//HelloWorld工厂合约：我作为一个项目方我提供一个HelloWorldFactory，
//用户就能使用这个工厂合约生成一个自己的HelloWorld

//我们可以通过引入合约来复用其他文件中的代码
//使用import关键字来引入合约

//第一种方法：要使用的合约在本地或与在同一目录下，可以直接通过相对路径来调用
import "./test4.sol";
//"."这个点表示路径在当前文件夹里面，"/"斜杠表示后面要加文件名了
//这个引入方式引入的是一个文件里面全部的合约
import { HelloWorld } from "./test4.sol";
//这个方式就是引入某个文件中的特定合约

//第二种方法：引入网络上的合约，打开要调用文件的Github把URL复制过来
import { HelloWorld } from "https://github.com/Orion-Sui/The_Path_to_Learning_Solidity/blob/main/Chapter-01/010106.sol";
//但是要注意这里的Github库里的文件地址需要是Public状态或者自己账号可见的状态

//第三种方法：通过包引入
//import { HelloWorld } from "@companyName/productName/contractName";
 