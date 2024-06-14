// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserPanel {
    // Kullanıcıların adreslerini, kullanıcı adlarını ve şifrelerini saklamak için bir struct
    struct User {
        string username;
        string password;
        bool registered;
    }

    // Kullanıcıların adreslerini saklamak için dinamik dizi
    address[] private userAddresses;

    // Kullanıcıların adreslerini kullanıcı bilgileriyle eşlemek için bir mapping
    mapping(address => User) private users;

    // Kullanıcı oluşturma olayı
    event UserRegistered(address indexed user, string username);

    // Kullanıcı adı ve şifre oluşturma işlevi
    function registerUser(string memory username, string memory password) public {
        // Kullanıcının daha önce kayıt olup olmadığını kontrol etme
        require(!users[msg.sender].registered, "Kullanici zaten kayitli");

        // Kullanıcıyı oluştur
        users[msg.sender] = User(username, password, true);
        userAddresses.push(msg.sender); // Yeni kullanıcının adresini diziye ekleyin
        emit UserRegistered(msg.sender, username);
    }

    // Kullanıcı adını ve şifresini almak için işlev
    function getUser(address userAddress) public view returns (string memory, string memory) {
        require(users[userAddress].registered, "Kullanici kayitli degil");
        return (users[userAddress].username, users[userAddress].password);
        
    }

    // Tüm kullanıcıları görüntülemek için işlev
    function getAllUsers() public view returns (address[] memory) {
        return userAddresses;
    }

    // Kullanıcı bilgilerini güncelleyen işlev
    function updateUser(address userAddress, string memory newUsername, string memory newPassword) public {
        require(users[userAddress].registered, "Kullanici kayitli degil");
        users[userAddress].username = newUsername;
        users[userAddress].password = newPassword;
    }
}
