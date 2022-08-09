// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

library Math{
    function plus(uint x,uint y) public pure returns(uint){
        return x+y;
    }
    function minus(uint x,uint y) public pure returns(uint){
        return x-y;
    }
    function multi(uint x,uint y) public pure returns(uint){
        return x*y;
    }
    function div(uint x,uint y) public pure returns(uint){
        require(y!=0,"Can't divide zero");
        return x/y;
    }

}

contract Library{
    function trial(uint x,uint y)public pure returns(uint){
        return Math.plus(x,y);
    }
}
contract Library2{
    using Math for uint;

    function trial(uint x,uint y)public pure returns(uint){
        return x.plus(y);
    }
}