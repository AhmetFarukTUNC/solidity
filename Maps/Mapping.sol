// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Mapping{

    mapping(address => bool) public registered;

    mapping (address => int256) public favNums;

    // User saves.

    function register(int256 _favNums) public {
        require(!isRegistered(),"There are this user.");
        registered[msg.sender] = true;
        favNums[msg.sender] = _favNums;
    }

    // It checks whether the new user is registered or not.

    function isRegistered() public view returns(bool){
        return registered[msg.sender];
    }

    // Delete register

    function deleteRegistered() public {
        require(isRegistered(),"There is no such user");
        delete(registered[msg.sender]);
        delete(favNums[msg.sender]);
    }
} 