import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-chai-matchers";
import "@nomiclabs/hardhat-ethers";
require("@nomicfoundation/hardhat-toolbox");

import "solidity-coverage";


const config: HardhatUserConfig = {
  solidity: "0.8.17",
};

export default config;
const INFURA_API_KEY = "2RG339bAIRgMizOvt8QFsVAlGcP";

const SEPOLIA_PRIVATE_KEY = "c1d7c6f6248de0f0e642b4b1e7467c97";

module.exports = {
  solidity: "0.8.9",
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY]
    }
  }
};