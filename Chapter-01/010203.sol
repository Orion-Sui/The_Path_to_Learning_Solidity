// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// solidity中的三种不同转账方式

// transfer
// send
// call

// transfer和send是纯转账，只发送2300矿工费，除了转账基本上干不了什么事
// call可以在转账的同时调用函数或者处理数据，call会把剩余的gas都发过去
// call可以处理纯转账和转账加数据，所以都用call就可以了

// transfer: transfer ETH and revert if tx failed
// 如果transfer失败双方金额没有任何变化
// 用法：addr.transfer(value) 
// 例：众筹合约里提款函数处：payable(msg.sender).transfer(address(this).balance);

// send: transfer ETH and return bool 
// 成功为true 失败为false
// 用法：addr.send(value) 
// 例：众筹合约里提款函数处：
// bool success = payable(msg.sender).send(address(this).balance);
// require(success, "tx failed")

// call: transfer ETH with data return value of function and bool
// 用法：(bool, result) = addr.call{value: value}("data")
// 例：众筹合约里提款函数处：
// bool success;
// (success, ) = payable(msg.sender).call{value: address(this).balance}("");
// require(success, "tx failed");


// transfer会导致连锁型回滚
// send不会导致连锁型回滚
// call也不会导致连锁型回滚

// 简单拍卖中的连锁回滚攻击
// 当黑客使用黑客攻击合约进行攻击时，因为黑客合约没有fallback函数所以转到黑客合约的钱就回变成死钱，会报错，所以整个退款函数就会回滚
// solidity语句改的状态都是本地的状态，所以无论这个黑客排在退款的第几个，
// 因为transfer会导致连锁型回滚，大家的转账都被回滚了，整个合约都被回滚了
// 排在前面的转账也没有被执行，所有人都无法收到钱了

/* 黑客攻击合约
import "./SimpleAuctionV1.sol";
contract haclV1 {
    function hack_bid(address addr) payable public {
        SimpleAuctionV1 sa = SimpleAuctionV1(addr);
        sa.bid.value(msg.value)();
    }
}
*/

/* 结束拍卖后的退款函数
// 结束拍卖，把最高的出价发送给受益人
// 并把未中标的出价者的钱返还
function auctionEnd() public {
    // 拍卖已截止
    require(now > auctionEnd);
    // 该函数未被调用过
    require(!ended);

    // 把最高的出价发送给受益人
    beneficiary.transfer(bids[highestBidder]);
    for (uint i = 0; i < bidders.length; ++i) {
        address bidder = bidders[i];
        if (bidder == highestBidder) continue;
        bidder.transfer(bids[bidder]); // 此处使用的就是transfer
    }

    ended = true;
    emit AuctionEnded(highestBidder, bids[highestBidder]);
}
*/