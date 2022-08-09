//SPDX-Licensed-Identifier: Unlicensed

pragma solidity ^0.8.0;

contract Interact{

    address public caller;
    mapping(address => uint256) public counts;

    function callThis() external{
        caller = msg.sender;
        counts[caller]++;
    }
}
/*
Interact yapan bir contract da msg.sender kullanımı tehlikelidir.
Örnek:

Caller contract ı interact contract ını kullanarak bir fonksiyon çağırıyor ve func ı çağıran kişi
caller contractın adresi oluyor , account adresi değil
payEth func ı bu yüzden parametre olarak adres alıyor

NASIL OLMAMALI

            // function payEth () external payable{
            //         userBalances[msg.sender] += msg.value; 
            //     }
*/

contract Pay{
    mapping(address => uint256) public userBalances;

    function payEth (address _payer) external payable{
        userBalances[_payer] += msg.value; 
    }
}
contract Caller{
    Interact interact;
    
    constructor(address _interactContract){
        interact = Interact(_interactContract);
    }



    function callInteract() external{
        interact.callThis();
    }

    function readCaller() external view returns (address){
        return interact.caller();
    }
    function readCallerCount() external view returns(uint256){
        return interact.counts(msg.sender);
    }

    function payToPay(address _payAddress) public payable{
        Pay pay = Pay(_payAddress);
        pay.payEth{value: msg.value}(msg.sender);

    }

    function senEthByTransfer() public payable{
        payable(address(interact)).transfer(msg.value);
    }


}