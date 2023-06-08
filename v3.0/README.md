# Version 3.0

Version 3.0 is an updated version of a project that involves creating a Dutch auction contract for selling NFTs (Non-Fungible Tokens). The previous version, 2.0, implemented the Dutch auction functionality using Ether bids, while version 3.0 extends this functionality to accept only ERC20 token bids instead of Ether.

Here are the steps involved in Version 3.0:

1. Create a new directory in the GitHub repository called v3.0: This step is necessary to maintain a separate version for the project. It helps in organizing and tracking changes made in each version.

2. Initialize a new hardhat project: Hardhat is a development environment for Ethereum smart contracts. By initializing a new hardhat project in the v3.0 directory, you set up the necessary environment for compiling, testing, and deploying the smart contracts.

3. Copy over reusable files from previous versions: The project has reusable files from previous versions. These files contain common code or logic that can be utilized in the current version. By copying them over to the v3.0 directory, you ensure code reusability and maintain consistency across versions.

4. Create a new contract called NFTDutchAuction_ERC20Bids.sol: In this version, a new contract is created to support Dutch auctions for NFTs with ERC20 token bids. This means that instead of using Ether, participants will bid with ERC20 tokens.

5. Define the constructor for NFTDutchAuction_ERC20Bids.sol: The constructor is a special function that is executed only once during contract deployment. It initializes the state variables and sets the initial conditions for the auction. The constructor for NFTDutchAuction_ERC20Bids.sol takes parameters such as the ERC20 token address, ERC721 token address, NFT token ID, reserve price, the number of blocks the auction will remain open, and the decrement in offer price.

6. Write test cases: Test cases are essential to ensure the correctness and reliability of the smart contracts. By writing thorough test cases, you can verify that the contract functions as intended and handles different scenarios correctly. These test cases will cover the functionality of both NFTDutchAuction_ERC20Bids.sol and any reused contracts from previous versions. The tests will be written in Solidity using a testing framework, and they will simulate various actions and behaviors of the contracts.

7. Generate a Solidity coverage report: Solidity coverage is a tool that helps measure the code coverage of your tests. By generating a coverage report, you can identify areas of the code that are not covered by tests. Committing the coverage report to the repository under the v3.0 directory ensures that it is saved and accessible for future reference.

By following these steps, Version 3.0 of the project is implemented, adding the functionality to support ERC20 token bids in the Dutch auction for NFTs.


```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```
