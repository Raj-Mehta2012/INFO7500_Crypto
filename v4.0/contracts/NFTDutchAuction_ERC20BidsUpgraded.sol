// SPDX-License-Identifier: MIT
// Author: Raj Mehta
// Version : 4.0
pragma solidity ^0.8.0;

import "./NFTDutchAuction_ERC20Bids.sol";


contract NFTDutchAuction_ERC20Upgraded is 
NFTDutchAuctionERC20{

    function currentVersion() public pure returns(uint)
    {
        return 2;
    }

}