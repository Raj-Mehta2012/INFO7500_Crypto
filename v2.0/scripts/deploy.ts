import { ethers } from "hardhat";

async function main() {
  // Deploy the TechnoCleverNFT contract
  const TechnoCleverNFT = await ethers.getContractFactory("DUTCH_NFT");
  const technoCleverNFT = await TechnoCleverNFT.deploy();
  await technoCleverNFT.deployed();
  console.log(`DUTCH_NFT deployed to ${technoCleverNFT.address}`);

  // Deploy the NFTDutchAuction contract
  const nftTokenId = 1;
  const reservePrice = ethers.utils.parseEther("1");
  const numBlocksAuctionOpen = 100;
  const offerPriceDecrement = ethers.utils.parseEther("0.01");

  const NFTDutchAuction = await ethers.getContractFactory("NFTDutchAuction");
  const nftDutchAuction = await NFTDutchAuction.deploy(
    technoCleverNFT.address,
    nftTokenId,
    reservePrice,
    numBlocksAuctionOpen,
    offerPriceDecrement
  );
  await nftDutchAuction.deployed();
  console.log(`NFTDutchAuction deployed to ${nftDutchAuction.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
