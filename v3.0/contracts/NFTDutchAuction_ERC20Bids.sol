// SPDX-License-Identifier: MIT
// Author: Raj Mehta
// Version : 3.0

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract NFTDutchAuctionERC20{

    uint reservePrice;
    uint numBlocksAuctionOpen;
    uint offerPriceDecrement;
    uint intialPrice;
    uint startingBlock;
    uint public auctionCloseBlock;
    address public sellerAccountAddr;
    address payable sellerAccount;
    bool auctionEnd = false;
    bool auctionStart = false;
    IERC721 public nft;
    uint nftID;
    IERC20 public tokenContract;

    constructor(address erc20TokenAddress, address erc721TokenAddress, uint256 _nftTokenId, uint _reservePrice, uint _numBlocksAuctionOpen, uint _offerPriceDecrement)
    {
        reservePrice = _reservePrice;
        numBlocksAuctionOpen = _numBlocksAuctionOpen;
        offerPriceDecrement = _offerPriceDecrement;
        nft = IERC721(erc721TokenAddress);
        nftID = _nftTokenId;
        tokenContract = IERC20(erc20TokenAddress);
    }

    function escrowNFT() public
    {
        sellerAccountAddr = msg.sender;
        sellerAccount = payable(msg.sender);
        require(nft.ownerOf(nftID) == sellerAccountAddr, "Only owner of the NFT can start the auction.");
        nft.safeTransferFrom(sellerAccountAddr, address(this), nftID);
        startingBlock = block.number;
        auctionCloseBlock = startingBlock + numBlocksAuctionOpen;
        auctionStart = true;
        intialPrice = reservePrice + (offerPriceDecrement * numBlocksAuctionOpen);
    }

    function bid(uint amount) public payable
    {
        require(auctionStart == true, "Auction is not started yet!");
        require(auctionEnd == false && (block.number < auctionCloseBlock), "Bids are not being accepted, the auction has ended.");
        require(amount >= (currentPrice()), "Your bid price is less than the required auction price.");
        finalize(amount);
    }

    function finalize(uint amount) internal nftEscrowed
    {
        require(tokenContract.allowance(msg.sender, address(this)) >= amount, "Insufficient Token Allowance.");
        require(tokenContract.balanceOf(msg.sender) >= amount, "Not enough balance in the wallet.");
        tokenContract.transferFrom(msg.sender, sellerAccountAddr, amount);
        nft.safeTransferFrom(address(this), msg.sender, nftID);
        auctionEnd = true;
    }

    function currentPrice() internal view returns (uint) 
    {
        uint blocksRemaining = auctionCloseBlock - block.number;
        uint currPrice = intialPrice - (blocksRemaining * offerPriceDecrement);
        return currPrice;
    }

    function endAuction() public nftEscrowed
    {
        require(msg.sender == sellerAccountAddr, "Invalid call, Only owner of this NFT can trigger this call.");
        require(auctionEnd == false, "Cannot halt the auction as it is successfully completed.");
        require(block.number > auctionCloseBlock, "Cannot halt the auction as it is in the process.");
        auctionEnd = true;
        nft.safeTransferFrom(address(this), sellerAccount, nftID);
    }

    function onERC721Received(address operator, address from, uint tokenId, bytes calldata data) public view returns(bytes4)
    {
        return IERC721Receiver.onERC721Received.selector;
    }

    modifier nftEscrowed() 
    {
        require(nft.ownerOf(nftID) == address(this),"Auction NFT is not escrowed.");
        _;
    }
}