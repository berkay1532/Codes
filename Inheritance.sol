// SPDX-Licensed-Identifier: Unlicensed

pragma solidity ^0.8.0;

contract A {
    uint public x;
    uint public y;

    function setX(uint _x)virtual public {//virtual keyword u kalıtım sağladığı diğer kontratlarda bu fonksiyon üzerinde değişiklilk yapılmasını mümkün kılar
        x = _x;
    }
    function setY(uint _y)public {
        y = _y;
    }    
}


//Inheritance A da bullan x ve y değişkenleri ve fonksiyonları B de yer alır 
contract B is A{
    uint public z;

    function setZ(uint _z)public{
        z = _z;
    }

    function setX(uint _x)override public{//değiştirilen fonksiyon override olarak işaretlenmeli
        x = _x+2;
    }

}

contract Human{
    function sayHello( ) public pure virtual returns(string memory){
        return "Merhaba Hosgeldiniz";
    }
}
contract SuperHuman is Human{

    function sayHello( ) override public pure returns (string memory){
        return "Selamlar web3 developer";
    }
    function welcomeMsg(bool isMember) public pure  returns(string memory){
        return isMember? sayHello(): super.sayHello();//super veya Human kullanılabilir
    }
    function retTrue()public pure returns(string memory){
        return "bir";
    }
}


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";



contract Wallet is Ownable {
    fallback() payable external{}

    function sendEtherr(address payable to, uint amount)onlyOwner public{
        to.transfer(amount);
    }
    function showBalance() public view returns(uint){
        return address(this).balance;
    }
}




