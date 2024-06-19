//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

contract SimpleStorage{
    uint256 favouriteNumber;
    bool favouriteBool;

    struct People{

       uint256 favouriteNumber;

        string name;
    }

    People[] public people;
    mapping(string=>uint256);

    function store(uint _favouriteNumber) public  {
        favouriteNumber = _favouriteNumber;
        
    }

    function retreive() public view returns(uint256){
        return favouriteNumber;
    }

    function addPerson(string memory _name,uint256 _favouriteNumber) public {
        people.push(People({favouriteNumber:_favouriteNumber,name:_name}));
    }
    
}