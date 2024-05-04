pragma solidity ^0.4.17;

contract Test{
    uint[] public myArray;

    string[] public myArray2;

    function Test() public{
        
        myArray.push(1);

        myArray.push(10);
        
        myArray.push(30);
   
    }

    function getMyArray() public view returns(uint[]){
        return myArray;
    }



    function getArraylength() public view returns(uint){
        return myArray.length;
    }

    function getFirstElement() public view returns(uint){
        return myArray[0];
    }

}