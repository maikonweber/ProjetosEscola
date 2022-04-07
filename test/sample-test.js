const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const schoolNFT = await ethers.getContractFactory("MyToken");
    const school = await schoolNFT.deploy();

    await school.deployed();

    const recipient = '0x2546bcd3c84621e976d8185a91a922ae77ecec30';
    const metadataUrl = 'cid/test.png';
    let balance = await school.balanceOf(recipient);

    const newlyMintedToken = await school.payToMint(recipient, metadataUrl, {
      value: ethers.utils.parseEther("0.5"),
    });
  
  
  });
});