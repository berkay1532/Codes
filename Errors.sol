//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Errors{
    uint public totalBalance;
    mapping(address => uint) public userBalances;

    error ExceedingAmount(address user, uint exceedingAmount);
    error Deny(string reason);
    receive() external payable{
        revert Deny("No direct payments");
    }
    fallback() external payable{
        revert Deny("No direct payments");
    }
    function pay() noZero(msg.value) external payable {
        require(msg.value == 1 ether,"Only pyments in 1 ether");

        totalBalance += 1 ether;
        userBalances[msg.sender] += 1 ether;
    }
    function withdraw(uint _amount) noZero(_amount) external {
        uint initalBalance = totalBalance;
        if(userBalances[msg.sender] < _amount){//we can also use require here 
            // revert("Invalid balance");
            revert ExceedingAmount(msg.sender,_amount-userBalances[msg.sender]);
        }

        totalBalance-= _amount;
        userBalances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount); 

        assert(totalBalance < initalBalance);
    }

    modifier noZero(uint _amount){
        require(_amount != 0);
        _;
    }

}