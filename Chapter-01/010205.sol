// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 修改器(封装)

    // 封装要求锁定期结束的代码
    modifier windowClosed(){
        // 限制生产商只能在锁定期结束后进行提款，否则返回提示信息窗口没关闭
        require(block.timestamp >= deploymentTimestamp + lockTime, "Window is not closed");
        _;
        
        // _下划线的意思是当你用了这个封装，如果你的下划线是在封装代码下面的
        // 他要先执行封装代码，这里也就是require，然后再执行调用封装的函数的其他代码
        // 也就是说下划线代表其他代码
        // 如果下划线在封装代码的上面，如：
        //        _;
        //        require(block.timestamp >= deploymentTimestamp + lockTime, "Window is not closed");
        // 那么就表示先执行调用封装的函数的其他代码，然后再执行封住代码，这里也就是require
        // 一般使用的场景都是_下划线放在封装函数的下面
        // 因为先进行判断在执行其他语句，在判断失败的时候就不会执行其他语句了，可以节省gas费
    }

// 需要调用的时候这样调用就好了
    function getFund() external windowClosed {
    function refund() public windowClosed returns (bool) {