// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
// UserPanel kontratına erişim için arayüz
    interface IUserPanel {
        function getAllUsers() external view returns (address[] memory);
    }
contract NewContract {
    // UserPanel kontratına erişmek için adres
    address public userPanelAddress;
// Yeni kontratın oluşturucusu, UserPanel kontratının adresini alır
    constructor(address _userPanelAddress) {
        userPanelAddress = _userPanelAddress;
    }
    

    

    // UserPanel kontratından kullanıcı adreslerini almak için işlev
    function getUsersFromUserPanel() public view returns (address[] memory) {
        // UserPanel kontratına erişim sağlama
        IUserPanel userPanel = IUserPanel(userPanelAddress);
        // Kullanıcı adreslerini al
        return userPanel.getAllUsers();
    }
}

