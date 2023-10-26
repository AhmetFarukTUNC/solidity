// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Events{
    struct Order{
        address customer;
        string zipCode;
        uint256[] products;
        Status status;

    }

    enum Status{
        Taken, // It is 0
        Preparing, // It is 1
        Boxed, // It is 2
        Shipped //It is 3

        
    }

    Order[] public orders;

    address public owner;

    

    constructor(){
        owner = msg.sender;
    }

    // Events send a message and we can show to user this message.

    // create order event...

    event OrderCreated(uint256 _orderId,address indexed _consumer);

    //change zip code event...

    event ZipChanged(uint256 _orderId,string _zip);


    function createOrder(string memory _zipCode,uint256[] memory _products) checkProducts(_products) external  returns(uint256) {

        //require(_products.length>0,"No products.");

        Order memory order;

        order.customer = msg.sender;
        order.zipCode = _zipCode;
        order.products = _products;
        order.status = Status.Taken;
        orders.push(order);

        emit OrderCreated(orders.length-1, msg.sender);

        return orders.length-1;

    }



    function advanceOrder(uint256 _orderId) checkOrderId(_orderId) onlyOwner shipped(_orderId) external {

        //require(owner == msg.sender,"You are not authorized.");

        //require(_orderId < orders.length,"Not a valid order id.");

        Order storage order = orders[_orderId];

        //require(order.status != Status.Shipped,"Order is already shipped.");
        if (order.status==Status.Taken) {
            order.status = Status.Preparing;
        }

        else if(order.status == Status.Preparing){
            order.status = Status.Boxed;
        }

        else if(order.status == Status.Boxed){
            order.status = Status.Shipped;
        }

    }

    function getOrder(uint256 _orderId) checkOrderId(_orderId) external view returns(Order memory){
        //require(_orderId<orders.length,"Not a valid order id.");

        Order memory order = orders[_orderId];

        return order;
    }
    

    function updateZip(uint256 _orderId,string memory _zip) checkOrderId(_orderId) onlyCustomer(_orderId) external  {
        //require(_orderId<orders.length,"Not a valid order id.");

        Order storage order = orders[_orderId];

        //require(order.customer == msg.sender,"You are not the owner of order.");

        order.zipCode = _zip;

        emit ZipChanged(_orderId, _zip);

    }

    // modifiers

    //This is a modifier for check that products is null

    modifier checkProducts(uint256[] memory _products){
        require(_products.length>0,"No products");
        _;
    }

    //This is a modifier for check according to orderId parameter to order.

    modifier checkOrderId(uint256 _orderId){
        require(_orderId<orders.length,"Not a valid order id.");
        _;
    }

    // This is a modifier for check that owner is real or no

    modifier onlyOwner{
        require(owner == msg.sender,"You are not authorized.");
        _;
    }

    //This s a modifier for ask this order is sender or no.

    modifier onlyCustomer(uint256 _orderId){
        require(orders[_orderId].customer == msg.sender,"You are not the owner of the order.");
        _;
    }

    // This is a modifier for shipped.

    modifier shipped(uint256 _orderId){
        require(orders[_orderId].status != Status.Shipped,"Order is already shipped.");
        
        _;
    }
     

    




}