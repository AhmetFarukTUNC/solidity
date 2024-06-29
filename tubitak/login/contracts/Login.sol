// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Login {
    struct User {
        string username;
        bytes32 passwordHash;
    }

    mapping(address => User) private users;
    mapping(string => address) private usernameToAddress;

    function register(string memory _username, string memory _password) public {
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(bytes(_password).length > 0, "Password cannot be empty");
        require(usernameToAddress[_username] == address(0), "Username already taken");
        require(bytes(users[msg.sender].username).length == 0, "User already exists");

        users[msg.sender] = User({
            username: _username,
            passwordHash: keccak256(abi.encodePacked(_password))
        });

        usernameToAddress[_username] = msg.sender;
    }

    function login(string memory _username, string memory _password) public view returns (bool) {
        address userAddress = usernameToAddress[_username];
        require(userAddress != address(0), "User does not exist");

        User memory user = users[userAddress];
        bytes32 passwordHash = keccak256(abi.encodePacked(_password));

        return user.passwordHash == passwordHash;
    }

    function getUser(address _userAddress) public view returns (string memory) {
        require(bytes(users[_userAddress].username).length > 0, "User does not exist");

        User memory user = users[_userAddress];
        return user.username;
    }
}

