// SPDX-License-Identifier: MIT
pragma solidity >0.5.0<=0.9.0;
 import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
 contract tokenstar is ERC20{
constructor(uint initalSupply)ERC20("shinnigStar","star") {
    _mint(msg.sender,initalSupply);
}
 }