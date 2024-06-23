// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleRegister {
    mapping(address => string) private names;

    function register(string memory _name) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        names[msg.sender] = _name;
    }

    function getName(address _user) public view returns (string memory) {
        return names[_user];
    }
}
