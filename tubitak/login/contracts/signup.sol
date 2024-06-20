// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;
// UserPanel kontratına erişim için arayüz
    interface IUserRegistry {
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
        IUserRegistry userPanel = IUserRegistry(userPanelAddress);
        // Kullanıcı adreslerini al
        return userPanel.getAllUsers();
    }
}

