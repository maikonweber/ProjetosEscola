pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract gatoXadreNFT is ERC721URIStorage {
    // auto-increment field for each token

    using Counters for Counters.Counter;
    Counters.Counter private _tokensIds;

    address contractAddress;


    constructor(address marktePlaceAddress) ERC721("gatoXadrezNFT", "GATX") {
        contractAddress = marktePlaceAddress;
    }

    function createToken(string memory _uri) public returns (uint) {
        // Set a new token id for the token to be minted
        _tokensIds.increment();
        uint256 newItemid = _tokensIds.current();

        _mint(msg.sender, newItemid); // mint the token to the sender
        _setTokenURI(newItemid, _uri); // genenrate the URI for the token
        setApprovalForAll(contractAddress, true); // Grant permission to marketplace
      
        // 
        return newItemid;
    }
        


}