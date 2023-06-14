// SPDX-License-Identifier: MIT
// Author: Raj Mehta
// Version : 1.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract BasicDutchAuction {
    uint256 public blocknumber;
    uint256 public offerprice = 0 ether;
    uint256 public initialPrice = 5 ether;
    uint256 public immutable startAt;
    uint256 public immutable endsAt;
    uint256 public immutable reservePrice = 1.5 ether;
    uint256 public immutable offerPriceDecrement = 0.01 ether;
    uint256 public immutable numBlocksAuctionOpen = 10;
    address public donor;
    uint256 public finalPrice;
    address public immutable owner;
    address public contractAddress;

    constructor() {
        startAt = block.number;
        endsAt = startAt + numBlocksAuctionOpen;
        initialPrice = reservePrice + numBlocksAuctionOpen * offerPriceDecrement;
        blocknumber = block.number;
        owner = msg.sender;
        contractAddress = address(this);
    }

    function price() public view returns (uint256) {
        if (endsAt < block.number) {
            return reservePrice;
        }

        return initialPrice - (block.number * offerPriceDecrement);
    }

    function checkbalance() public view returns (uint256) {
        return contractAddress.balance;
    }

    function receiveMoney() public payable {
    require(donor == address(0), "Someone has already donated");
    require(msg.value >= price(), "Not enough ether sent.");

    donor = msg.sender;
    finalPrice = price();

    (bool sentFinalPriceETH, ) = owner.call{value: finalPrice}("");
    console.log("sentFinalPriceETH: ", sentFinalPriceETH);
    require(sentFinalPriceETH, "Ether transfer to donor address is failed");
    console.log("amount sent ", msg.value, "final price ", finalPrice);

    if (msg.value > finalPrice) {
        console.log("amount to be transferred ", contractAddress.balance);
        (bool sentRemainingETH, ) = msg.sender.call{value: msg.value - finalPrice}("");
        require(sentRemainingETH, "Couldn't send remaining ether");
        console.log("Balance after transfer ", contractAddress.balance);
    }
}


}
    

// pragma solidity >=0.7.0 <0.9.0;

// import "hardhat/console.sol";

// contract BasicDutchAuction {
//     uint256 public blocknumber;
//     uint256 public offerprice = 0 ether;
//     uint256 public initialPrice = 5 ether;
//     uint256 public immutable startAt;
//     uint256 public immutable endsAt;
//     uint256 public immutable reservePrice = 1.5 ether;
//     uint256 public immutable offerPriceDecrement = 0.01 ether;
//     uint256 public immutable numBlocksAuctionOpen = 10;
//     address public donor;
//     uint256 public finalPrice;
//     address public immutable owner;
//     address public contractAddress;

//     constructor() {
//         startAt = block.number;
//         endsAt = startAt + numBlocksAuctionOpen;
//         initialPrice = reservePrice + numBlocksAuctionOpen*offerPriceDecrement;
//         blocknumber = block.number;
//         owner = msg.sender;
//         contractAddress = address(this);
//     }

//     function price() public view returns (uint256) {
//         if (endsAt < block.number) {
//             return reservePrice;
//         }

//         return initialPrice  - (block.number * offerPriceDecrement);

//     }
    
//     function checkbalance() public view returns (uint256) {
//         return contractAddress.balance;
//     }

//     function receiveMoney() public payable {
//         require(donor == address(0), "Someone has already donated");
//         require(msg.value >= price(), "Not enough ether sent.");

//         donor = msg.sender;
//         finalPrice = price();

//         (bool sentFinalPriceETH,) = owner.call{value:finalPrice}("");
//         require(sentFinalPriceETH, "Ether transfer to donor addrress is failed");
//         console.log("amount sent ", msg.value, "final price ", finalPrice);

//         if(msg.value > finalPrice){
//             console.log("amount to be transferred ", contractAddress.balance);
//             (bool sentRemainingETH,) = msg.sender.call{value: msg.value - finalPrice}("");
//             require(sentRemainingETH, "Couldn't send remaining ether");
//             console.log("Balance after transfer ", contractAddress.balance);
//         }

//     }
// }
