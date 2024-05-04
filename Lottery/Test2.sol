pragma solidity ^0.4.17;

contract Ornek{

    string[] public myArray;

    function Test() public {

        myArray.push("hi");

    }

    function getArray() public view returns(string[]){

       return myArray;

    }

}