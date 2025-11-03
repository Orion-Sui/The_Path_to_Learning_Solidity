// chainlink预言机喂价
// https://docs.chain.link/

// datafeed 开始使用处有示例合约:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED
 * VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */

/**
 * If you are reading data feeds on L2 networks, you must
 * check the latest answer from the L2 Sequencer Uptime
 * Feed to ensure that the data is accurate in the event
 * of an L2 sequencer outage. See the
 * https://docs.chain.link/data-feeds/l2-sequencer-feeds
 * page for details.
 */

contract DataConsumerV3 {
    AggregatorV3Interface internal dataFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */
    constructor() {
        dataFeed = AggregatorV3Interface(
            0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        );
    }

    /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }
}

// 获取预言机地址：

// Feed地址里面可以找到PriceFeed地址
// 首先选择公链，选择Ethereum链
// 然后选择主网/Sepolia测试网等等，找到需要的价格对的地址
// 这里的预言机地址是以太坊Sepolia测试网上的地址，用来获取以太坊对USD的价格
// 如果是其他链，可以去chainlink的官网上找到对应的预言机地址


// 喂价数据精度：

// 如果价格对 对的是ETH的话精度就有10的18次方
// 如果价格对 对的是USD的话精度就有10的8次方   
// 即： ETH    / USD  precision = 10 ** 8
//      某资产  / ETH precision = 10 ** 18