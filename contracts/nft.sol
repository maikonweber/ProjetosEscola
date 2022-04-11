pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract gatoXadrezNFT is ERC721URIStorage {
    // auto-increment field for each token

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address contractAddress;

    constructor(address marketplaceAddress) ERC721("Partnerverse Tokens", "PNVT"){
       contractAddress = marketplaceAddress;
    }

    /// @notice create a new token
    /// @param tokenURI : token URI
    function createToken(string memory tokenURI) public returns(uint) {
        //set a new token id for the token to be minted
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        //mint the token with ERC20 _tokenAddress
        _safeMint(msg.sender, newItemId); //mint the token
        _setTokenURI(newItemId, tokenURI); //generate the URI
        setApprovalForAll(contractAddress, true); //grant transaction permission to marketplace

        //return token ID
        return newItemId;

    }
    
}
