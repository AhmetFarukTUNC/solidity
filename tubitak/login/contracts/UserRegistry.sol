// SPDX-License-Identifier: MIT
pragma solidity 0.7.3;

contract UserRegistry {
    struct User {
        string name;
        address walletAddress;
        bool isAdmin;
    }

    mapping(address => User) private users;
    address[] private userAddresses;

    address public admin;

    event UserAdded(address indexed userAddress, string name, bool isAdmin);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    constructor() {
        admin = msg.sender; // Contract creator is the initial admin
    }

    function addUser(string memory _name, address _walletAddress, bool _isAdmin) public {
        require(_walletAddress != address(0), "Invalid address");
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(users[_walletAddress].walletAddress == address(0), "User already exists");

        users[_walletAddress] = User(_name, _walletAddress, _isAdmin);
        userAddresses.push(_walletAddress);

        emit UserAdded(_walletAddress, _name, _isAdmin);
    }

    function getUser(address _walletAddress) public view returns (string memory, address, bool) {
        require(_walletAddress != address(0), "Invalid address");

        User memory user = users[_walletAddress];
        return (user.name, user.walletAddress, user.isAdmin);
    }

    function isAdmin(address _walletAddress) public view returns (bool) {
        require(_walletAddress != address(0), "Invalid address");

        return users[_walletAddress].isAdmin;
    }

    function getUserCount() public view returns (uint) {
        return userAddresses.length;
    }

    function changeAdmin(address _newAdmin) public onlyAdmin {
        require(_newAdmin != address(0), "Invalid address");

        admin = _newAdmin;
    }
}

