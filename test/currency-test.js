const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    
    const [owner, addr1, addr2] = await ethers.getSigners();

    const Token = await ethers.getContractFactory('MyToken');

    const hardhatToken = await Token.deploy();
    const ownerBalance = await hardhatToken.balanceOf(owner.address);
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
    // TransferFor 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
        // 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
        
    await hardhatToken.transfer(addr1.address, 50);
    expect(await hardhatToken.balanceOf(addr1.address)).to.equal(50);

    await hardhatToken.transfer(addr2.address, 50);
    expect(await hardhatToken.balanceOf(addr2.address)).to.equal(50);


  
  });
});