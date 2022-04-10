// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract colegioGatoXadrez is ERC20, Ownable {
    address public admin;

    constructor() ERC20("", "MYT") {
        _mint(msg.sender, 10000 * 10 ** 18);
        admin = msg.sender;

    } 

    function mint(address to, uint256 amount) public {
        require(msg.sender == admin, "only admin can mint");
        mint(to, amount);
    }

    function burn(uint amount) external {
        _burn(msg.sender, amount);
    }

    
}
