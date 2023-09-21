// SPDX-License-Identifier: MIT
pragma solidity >0.5.0<=0.9.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "token.sol";

contract nftToken is ERC721{
    constructor(uint initialSupply)ERC721("star", "ST"){

    }
    function mint(address to, uint256 tokenID)public {
        _mint(to, tokenID);
    }
}

   contract NFTstake{
       nftToken public item;
       tokenstar  erc;
       address public owner;
        mapping (address=>uint) public  stakedtoken;
        mapping (address=> uint) public reward;
        mapping (address=>uint)public tokentimestamp;
        mapping(address => uint) public stakingCount; // Track the number of stakes per user

    uint constant MAX_STAKES = 2;

        constructor(address itemadress, address _erc){
            item=nftToken(itemadress);
            erc=tokenstar(_erc);
            owner=msg.sender;
        }
        function deposit(uint tokenID) public {
            require(tokenID>0, "ID must be greater than zero");
            require(item.getApproved(tokenID)==address(this), "not approved");
            require(stakingCount[msg.sender] < MAX_STAKES, "Exceeded maximum staking limit");

          
            
            item.transferFrom(msg.sender, address(this), tokenID);
            stakedtoken[msg.sender]+=tokenID;
             tokentimestamp[msg.sender] = block.timestamp;


        
        }
        function withdraw(uint tokenIDUN)external {
            uint tokenID= tokenIDUN;
            require(tokenID>0, "no token staked ");
            require(block.timestamp>=tokentimestamp[msg.sender]+1 minutes, "time les than one min");
            uint calreward=5;
            uint rewardamount=calreward;
            item.transferFrom(address(this), msg.sender, tokenIDUN);
            erc.transfer(msg.sender, rewardamount);
            stakedtoken[msg.sender]=0;
        }
            
            function returnNFT() external {
               require(stakedtoken[msg.sender] > 0, "No tokens staked");

               // Transfer the staked NFT back to the user
               uint tokenID = stakedtoken[msg.sender];
               item.transferFrom(address(this), msg.sender, tokenID);

              // Reset the staked token and reward for the user
                 stakedtoken[msg.sender] = 0;
                 reward[msg.sender] = 0;
    }

 }