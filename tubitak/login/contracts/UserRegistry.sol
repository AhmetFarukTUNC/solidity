// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserRegistry {
    struct User {
        string username;
        string password;
    }

    mapping(address => User) private users;

    function register(string memory _username, string memory _password) public {
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(bytes(_password).length > 0, "Password cannot be empty");
        require(bytes(users[msg.sender].username).length == 0, "User already exists");

        users[msg.sender] = User({
            username: _username,
            password: _password
        });
    }

    function getUser(address _userAddress) public view returns (string memory, string memory) {
        require(bytes(users[_userAddress].username).length > 0, "User does not exist");

        User memory user = users[_userAddress];
        return (user.username, user.password);
    }
}
