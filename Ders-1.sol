// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Ballot {
    uint public count = 4;
    string private name ="Berkay";
    bool private isHuman = true;
    address sender;


    constructor(uint initCount,string memory initName,bool initIsHuman){
        count = initCount;
        name = initName;
        isHuman = initIsHuman;
        sender = msg.sender;
    }

    function getName() public view returns(string memory){
        return name;
    }

    function setName(string memory newName) public{
        name = newName;
    }
    function getAddress() public view returns(address){
        return sender;
    }
    function getIsHuman()public view returns(bool){
        return isHuman;
    }
    function setIsHuman(bool newIsHuman)public{
        isHuman = newIsHuman;
    }

    function getCount() public view returns(uint){
        return count;
    }
    function setCount(uint newCount) public{
        count = newCount;
    }
    function setAddress()public{
        sender = msg.sender;
    }
 
}