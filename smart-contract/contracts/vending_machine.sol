// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract Lottery{
    address public owner;
    address payable[] public players;

    modifier onlyOwner(){
        require(msg.sender==owner);
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function enter() public payable{
        require(msg.value > .001 ether);
        //address of player entering lottery
        players.push(payable(msg.sender));
    }

    function getRandomNumber() public view returns (uint){
        return uint( keccak256(abi.encodePacket(owner, block.timestamp)) );
    }

    function pickWinner() public onlyOwner{
        //generate random modulated number
        uint index = getRandomNumber() % player.length;
        //take winner and transfer to his account the balance of the contract
        players[index].transfer(address(this).balance);

        //reset the state of the contract
        players = new address payable[](0);
    }

}
