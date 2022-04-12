pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract gatoXadrezMarket is ReentrancyGuard  {
    using Counters for Counters.Counter;

    Counters.Counter private _itemSold;
    Counters.Counter private _itemIds; // Total number of items sold

    address payable owner; // owner of the token
    uint256 listingPrice = 0.5 ether;// Have to pay to puy ther NFT on this marktplace

    constructor() {
        owner = payable(msg.sender);
        
    }

    struct MarketItem {
        uint256 itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }
    // Way to acess values of the markitem struct above by passing 
    mapping (uint256 => MarketItem) private idMarketItem;
    
    // log message when item as sold

    event MarketItemCreated (
        uint indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address  seller,
        address  owner,
        uint256 price,
        bool sold
    );

    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    function createMarketItem(address nftContract,
        uint256 tokenId,
        uint256 price) public payable nonReentrant{
            require(price > 0, "price cannot be zero");
            require(msg.value == listingPrice, "Price listing price");
            _itemIds.increment();
            uint256 itemId = _itemIds.current();
            idMarketItem[itemId] = MarketItem(
                 itemId, 
                    nftContract, 
                 tokenId, 
                payable(msg.sender), //Address of the seller putting the nft up for sale
                payable(address(0)),    // No owner yet (set owener to empy address)
                 price,
                 false
            );
        
        // transfer owner of the nef to contract itselft
        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);
        
        emit MarketItemCreated(
             itemId,
             nftContract,
             tokenId,
             msg.sender,
             address(0),
             price,
             false);

        
    }

    function createMarketSale( address nftContract, uint256 itemid)  public payable nonReentrant {
                uint price = idMarketItem[itemid].price;
                uint tokenId = idMarketItem[itemid].tokenId;
                require(msg.value == price, "Price must be equal to the price of the item");
                // Pay the seller the amount

                idMarketItem[itemid].seller.transfer(msg.value);
                // Transfer ownership of the nft from the contratc itself to buyer

                IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
                idMarketItem[itemid].owner = payable(msg.sender);  // mark buyer as new orner
                idMarketItem[itemid].sold = true; // Mark that it has been sold
                _itemSold.increment(); // increment the total number of itens sold by 1
                payable(owner).transfer(listingPrice);
                }

                function fetchMarketItems() public view returns (MarketItem[] memory) {
                  uint itemCount = _itemIds.current(); // Total number of items created
                  uint unsoldItemCount  = _itemIds.current() - _itemSold.current(); // total number of items that are unsold =  total intens evert created
                  uint currentIndex = 0;

                  MarketItem[] memory items = new MarketItem[](unsoldItemCount);
                  for (uint i = 0 ; i < itemCount; i++) {
                      // loop through all items and add them to the array if they are unsold
                        // Check if the item is sold
                        // by checking if the owner is empty
                    if (idMarketItem[i + 1].owner == address(0)) {
                        uint currentId = idMarketItem[i + 1].itemId;
                        MarketItem storage currentItem = idMarketItem[currentId];
                        items[currentIndex] = currentItem;
                        currentIndex += 1;
                    }
                  }
                    return items;   // return the array of items
                }

                function fetchmyNFTs() public view returns (MarketItem[] memory) {
                    // Get total number of itemns ever created
                    uint totalItemCount = _itemIds.current();   
                    uint itemCount = 0;
                    uint currentIndex =0;
                    for(uint i = 0; i < totalItemCount; i++) {
                        if(idMarketItem[i+1].owner == msg.sender) {
                            itemCount += 1;

                        }
                    }

                    MarketItem[] memory items = new MarketItem[](itemCount);
                    for(uint i = 0; i < totalItemCount; i++) {
                        if(idMarketItem[i+1].owner == msg.sender) {
                            uint currentId = idMarketItem[i+1].itemId;
                            MarketItem storage currentItem = idMarketItem[currentId];
                            items[currentIndex] = currentItem;
                            currentIndex += 1;
                        }
                    }

                    return items;
                }
}
                   
 

    

    // function _baseURI() internal pure override returns (string memory) {
    //     return 'ipfs://';
    // }
    
    // function safeMint(address to, string memory uri) public onlyOwner {
    //     uint256 tokenId = _tokenIdCounter.current();
    //     _tokenIdCounter.increment();
    //     _safeMint(to, tokenId);
    //     _setTokenURI(tokenId, uri);
    // }

    // // The following functions are overrides required by Solidity.

    // function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
    //     super._burn(tokenId);
    // }

    // function tokenURI(uint256 tokenId)
    //     public
    //     view
    //     override(ERC721, ERC721URIStorage)
    //     returns (string memory)
    // {
    //     return super.tokenURI(tokenId);
    // }

    // function isContentOwned(string memory uri) public view returns (bool) {
    //     return existingURI[uri] == 1;
    // }

    // function payToMint(
    //     address recipient,
    //     string memory metaDataURI

    // ) public payable returns (uint256) {
    //     require(existingURI[metaDataURI] != 1, "NFT already minted");
    //     require(msg.value >= 0.05 ether, "Must send a positive amount");

    //     uint256 newItemId = _tokenIdCounter.current();
    //     _tokenIdCounter.increment();
    //     existingURI[metaDataURI] = 1;
    //     _mint(recipient, newItemId);
    //     _setTokenURI(newItemId, metaDataURI);
    //     return newItemId;
    

   



