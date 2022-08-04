// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Bank is Ownable{

    mapping(address => uint) balances;

    function sendEtherToContract() payable external{
        balances[msg.sender] = msg.value;
    }

    function withdraw(address payable to,uint amount) external checkAmount(amount){
        to.transfer(amount);
        balances[msg.sender] -= amount;

        //transfer fonksiyonu bakiye yetersiz ise revert eder
        //send fonksiyonu true false olarak işlem sonucunu döner
        //call fonksiyonu true false ve yanında istek olursa bir data döner ex: (bool sent, byte memory data) = to.call{value:amount}(" ");



    }

function sayHello() external onlyOwner returns(string memory ) {
return "sa";
}

    function showBalance()  external view returns(uint){
        return balances[msg.sender];
    }


    modifier checkAmount(uint amount){
        require(balances[msg.sender] >= amount,"Bakiye Yetersiz.");
        _;
    }

    uint public receiveCount = 0;
    uint public fallbackCount = 0;


    receive() external payable{//recieve fonksiyon kullanmadan sadece ether aktarımı yapar data aktarmaz 
        receiveCount++;
        balances[msg.sender] += msg.value;
    }
    fallback() external payable{//fallback fonksiyon kullanmadan receive fonksiyonu yoksa ether veya ether ve data  varsa sadece ether ve data aktarımı yapar
        fallbackCount++;
    }




}