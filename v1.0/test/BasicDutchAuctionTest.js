const {
    time,
    loadFixture,
    mine,
  } = require("@nomicfoundation/hardhat-network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect, assert } = require("chai");
  
  
  describe("Lock", function () {
    async function BasicDutchAuctiondeploy() {
  
      const [owner, otherAccount] = await ethers.getSigners();
  
      const BasicDutchAuction = await ethers.getContractFactory("BasicDutchAuction");
      const basicdutchauction = await BasicDutchAuction.deploy();
      // get default signer, in Signer abstraction form
      signer = ethers.provider.getSigner(0);
  
      // get default signer, but just the address!
      [signerAddress] = await ethers.provider.listAccounts();
      return { basicdutchauction, owner, otherAccount };
    }
  
    describe("Deployment", function () {
      it("Check if the starting block is 0", async function () {
        const { basicdutchauction, owner } = await loadFixture(BasicDutchAuctiondeploy);
        expect(await basicdutchauction.blocknumber()).to.equal(1);
      });
  
      it("Check if the initialPrice is 1600000000000000000 wei", async function () {
        var bigNum = BigInt("1600000000000000000");
        const { basicdutchauction, owner } = await loadFixture(BasicDutchAuctiondeploy);
        expect(await basicdutchauction.initialPrice()).to.equal(bigNum);
      });
  
      it("Accepts higher bid of 10ETH. Other account gets the bid amount & remaining ether is transferred to donor.", async function () {
        var bigNum = BigInt("10000000000000000000");
        var expectedOwnerBalance = BigInt("10001578551551250000000");
        var expectedOtherAccBalance = BigInt("9998419999999999910542");
        const { basicdutchauction, owner, otherAccount } = await loadFixture(BasicDutchAuctiondeploy);
        await expect(basicdutchauction.connect(otherAccount).receiveMoney({ value: bigNum })).eventually.to.ok;
        
        const ownerBalance = await owner.getBalance();
        const ownerBalanceDiff = expectedOwnerBalance - BigInt(ownerBalance);
        expect(ownerBalanceDiff).to.be.at.most(BigInt("1000000000000000000")); // Allow a difference of up to 1 ETH
        
        const otherAccBalance = await otherAccount.getBalance();
        const otherAccBalanceDiff = expectedOtherAccBalance - BigInt(otherAccBalance);
        expect(otherAccBalanceDiff).to.be.at.most(BigInt("1000000000000000000")); // Allow a difference of up to 1 ETH
        
        expect(await basicdutchauction.checkbalance()).to.equal(0);
    });
    
    
  
      it("Rejects lower bid", async function () {
        var bigNum = BigInt("1400000000000000000");
        const { basicdutchauction, owner } = await loadFixture(BasicDutchAuctiondeploy);
        await expect(basicdutchauction.receiveMoney({ value: bigNum })).to.be.revertedWith('Not enough ether sent.');
      });
  
      it("Rejects second bid ", async function () {
        var bigNum = BigInt("1600000000000000000");
        const { basicdutchauction, owner } = await loadFixture(BasicDutchAuctiondeploy);
        await expect(basicdutchauction.receiveMoney({ value: bigNum })).eventually.to.ok;
        await expect(basicdutchauction.receiveMoney({ value: bigNum })).to.be.revertedWith('Someone has already donated');
      });
  
      it("After block 10, price should be 1.5 ETH. Here, block number is 15", async function () {
        var priceBigNum = BigInt("1500000000000000000");
        const ModifyVariable = await ethers.getContractFactory("BasicDutchAuction");
        const contract = await ModifyVariable.deploy();
        await contract.deployed();
        await mine(1000);
        const newX = await contract.blocknumber();
        expect(await contract.price()).to.equal(priceBigNum);
      });
  
      it("Initial contract balance is 0", async function () {
        const ModifyVariable = await ethers.getContractFactory("BasicDutchAuction");
        const contract = await ModifyVariable.deploy();
        await contract.deployed();
        expect(await contract.checkbalance()).to.equal(0);
      });

      it("Reverts if ether transfer to the donor address fails", async function () {
        const { basicdutchauction, owner, otherAccount } = await loadFixture(BasicDutchAuctiondeploy);
        console.log("Owner: ", owner);
        const bigNum = BigInt("6000000000000000000");
    
        // Mock a failure during the ether transfer
        const mockTransfer = false;
        const mockCallReturnValue = [mockTransfer, "Ether transfer to donor address is failed"]; // Failure and an error message
    
        // Mock the `call` function to return the desired result
        owner.call = async () => {
            console.log("Mock call function called");
            return mockCallReturnValue;
        };
    
        await expect(basicdutchauction.connect(otherAccount).receiveMoney({ value: bigNum })).to.be.revertedWith('Ether transfer to donor address is failed');
    });
    
    
  
  
    });
  
  });
  