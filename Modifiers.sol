// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
//Modifiers examples
contract Modifiers{


    Order[] public orders;
    address public owner;
    uint public counter;

    enum Status{
        Taken,
        Preparing,
        Shipping,
        Done
    }

    struct Order{
        address customer;
        string zipCode;
        uint [] products;
        Status status;
    }
    constructor(){
        owner = msg.sender;
    }


    function createOrder(string memory _zipCode, uint[] memory _products) incCount external returns(uint){
        require(_products.length > 0 , "No products");

        Order memory order;
        order.customer = msg.sender;
        order.zipCode = _zipCode;
        order.products = _products;
        order.status = Status.Taken;
        orders.push(order);

        return orders.length - 1;
    }
    
    function advancedOrder(uint _orderId) checkOrderId(_orderId) incCount external {
        require(owner == msg.sender,"You are not authorized");
        // require(_orderId < orders.length,"Not a valid orde id");

        Order storage order = orders[_orderId];
        require(order.status != Status.Shipping ,"Order is already shipped");

        if (order.status == Status.Taken) {
                order.status = Status.Preparing;
        } else if (order.status == Status.Preparing) {
                order.status = Status.Shipping;
        } else if (order.status == Status.Shipping) {
                order.status = Status.Done;
        }
    }
 
    function getOrder(uint _orderId) checkOrderId(_orderId) public view returns(Order memory){
        // require(_orderId <orders.length,"Not a valid order id");
        return orders[_orderId];
    }

    function updateOrder(uint _orderId,string memory _zip) checkOrderId(_orderId) checkOwner(_orderId) incCount  external{
        // require(_orderId<orders.length,"Not a valid order id");
        // require(orders[_orderId].customer == msg.sender,"You are not the customer of the order");
        orders[_orderId].zipCode = _zip;
    }

    modifier checkOrderId(uint _orderId){
        require(_orderId <orders.length,"Not a valid order id");
        _;
    }

    modifier checkOwner(uint _orderId){
        require(orders[_orderId].customer == msg.sender,"You are not the customer of the order");
        _;
    }
    modifier incCount(){//Her transaction da counter arttırıyor
        _;
        counter++;
    }
    // _; işareti kodun o kısımda devam ettiğini belirtiyor
}
