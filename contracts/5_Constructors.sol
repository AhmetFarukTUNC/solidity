// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Constructor{
    // string public tokenName;
    // uint public totalSuply;
    // //contructor runs one times.
    // constructor(string memory name,uint number){
    //     tokenName=name;
    //     totalSuply=number;
    // }

    // function setNumber(uint number) public {
    //     totalSuply=number;
    // }

    //constant variable are constant and inmutable.

    // Example for constant

    // uint public constant number2 = 10;

    // function setNumber2(uint num) public {
    //     number2 =num;
    // }

    //Example for immutable

    uint public immutable number3;
    address public immutable owner;


    constructor(uint num2){
        number3 =num2;
        owner = msg.sender;
    }

    
}