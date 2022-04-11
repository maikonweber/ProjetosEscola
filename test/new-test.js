const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTMARKET", function () {
    it('Should create and execute market sales', async function () {
        const market = await ethers.getContractFactory('gatoXadrezMarket');
        const Market = await market.deploy();
        await Market.deployed();
        const marketAddress = Market.address;

        const NFT = await ethers.getContractFactory('gatoXadrezNFT');
        const nft = await NFT.deploy(marketAddress);
        await nft.deployed();
        const nftContractAddress = nft.address;

        let listingPrice = await Market.getListingPrice();
        listeingPrice = listingPrice.toString();
        expect(listingPrice).to.equal(ethers.utils.parseEther("0.5"));

        const auctionPrice = ethers.utils.parseUnits('100', 'ether');

        await nft.createToken('http://www.test.com')
        await nft.createToken('http://www.test.com')

        await Market.createMarketItem(nftContractAddress, 1,auctionPrice, {
            value : listingPrice
        }
        );

        await Market.createMarketItem(nftContractAddress, 2,auctionPrice, {
            value : listingPrice
        }
        );

        const [_, buyerAddress] = await ethers.getSigners();

        await Market.connect(buyerAddress).createMarketSale(nftContractAddress, 1,
            {value: auctionPrice});
        
        let items = await Market.fetchMarketItem();
        
        items = await Promise.all(items.map(async i => {
            const tokenUri = await nft.tokenURI(i.tokenId);

            let item = {
                price: i.price.toString(),
                tokenId: i.tokenId.toString(),
                tokenUri: tokenUri,
                owner: i.owner,
                tokenUri
            }
            return item;
        }))

        console.log(items, 'items');
    });  

    })