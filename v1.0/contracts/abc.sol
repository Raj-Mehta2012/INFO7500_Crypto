// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./BasicDutchAuction.sol";
contract test {
    BasicDutchAuction test;
    constructor () {
        test = new BasicDutchAuction();
    }
    function targetTest() external payable{
        test.receiveMoney{value: msg.value}();
    }
}