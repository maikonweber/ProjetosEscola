pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyToken is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    mapping(string => uint8) existingURI;

    constructor() ERC721("MyToken", "MTK") {

    }

    function _baseURI() internal pure override returns (string memory) {
        return 'ipfs://';
    }
    
    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function isContentOwned(string memory uri) public view returns (bool) {
        return existingURI[uri] == 1;
    }

    function payToMint(
        address recipient,
        string memory metaDataURI

    ) public payable returns (uint256) {
        require(existingURI[metaDataURI] != 1, "NFT already minted");
        require(msg.value >= 0.05 ether, "Must send a positive amount");

        uint256 newItemId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        existingURI[metaDataURI] = 1;
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, metaDataURI);
        return newItemId;
    }

    function count() public view returns (uint256) {
        return _tokenIdCounter.current();
    }



}