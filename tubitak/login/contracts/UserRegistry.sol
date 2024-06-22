// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

contract UserRegistry {
    struct User {
        string username;
        bytes32 passwordHash;
    }

    mapping(address => User) private users;

    event UserRegistered(address indexed userAddress, string username);

    function register(string memory _username, string memory _password) public {
        require(bytes(users[msg.sender].username).length == 0, "User already registered");

        bytes32 passwordHash = keccak256(abi.encodePacked(_password));

        users[msg.sender] = User({
            username: _username,
            passwordHash: passwordHash
        });

        emit UserRegistered(msg.sender, _username);
    }

    function getUsername(address _userAddress) public view returns (string memory) {
        require(bytes(users[_userAddress].username).length != 0, "User not registered");
        return users[_userAddress].username;
    }

    function checkPassword(string memory _password) public view returns (bool) {
        require(bytes(users[msg.sender].username).length != 0, "User not registered");

        bytes32 passwordHash = keccak256(abi.encodePacked(_password));
        return users[msg.sender].passwordHash == passwordHash;
    }
}
