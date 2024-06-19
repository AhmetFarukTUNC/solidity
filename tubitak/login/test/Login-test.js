const { expect } = require("chai");

const { ethers } = require("ethers");

describe("UserPanel", function () {
    let UserPanel; // Kontratın instance'ı için değişken
    let userPanel; // Kontrat instance'ı
    let owner; // Sahip adresi
    let addr1; // Test adresi 1
    let addr2; // Test adresi 2

    // Her test öncesinde yapılacak işlemler
    beforeEach(async function () {
        // UserPanel kontratının factory'sini ethers ile alıyoruz
        UserPanel = await ethers.getContractFactory("UserPanel");
        // Test için kullanılacak adresleri alıyoruz
        [owner, addr1, addr2, _] = await ethers.getSigners();
        // UserPanel kontratını deploy ediyoruz
        userPanel = await UserPanel.deploy();
        // Kontratın deploy edildiğinden emin oluyoruz
        await userPanel.deployed();
    });

    // Yeni kullanıcı kaydı testi
    it("should register a new user", async function () {
        await userPanel.registerUser("user1", "password1");
        const user = await userPanel.getUser(owner.address);
        expect(user[0]).to.equal("user1");
        expect(user[1]).to.equal("password1");
    });

    // Zaten kayıtlı olan bir kullanıcının tekrar kaydolmaması testi
    it("should not register an already registered user", async function () {
        await userPanel.registerUser("user1", "password1");
        await expect(userPanel.registerUser("user1", "password1")).to.be.revertedWith("Kullanici zaten kayitli");
    });

    // Kullanıcı bilgilerinin güncellenmesi testi
    it("should update user information", async function () {
        await userPanel.registerUser("user1", "password1");
        await userPanel.updateUser(owner.address, "newUser1", "newPassword1");
        const user = await userPanel.getUser(owner.address);
        expect(user[0]).to.equal("newUser1");
        expect(user[1]).to.equal("newPassword1");
    });

    // Tüm kullanıcıları listeleme testi
    it("should get all users", async function () {
        await userPanel.registerUser("user1", "password1");
        await userPanel.connect(addr1).registerUser("user2", "password2");
        const allUsers = await userPanel.getAllUsers();
        expect(allUsers).to.have.lengthOf(2);
        expect(allUsers).to.include(owner.address);
        expect(allUsers).to.include(addr1.address);
    });

    // Kullanıcı bilgilerini getirme testi
    it("should return user details", async function () {
        await userPanel.registerUser("user1", "password1");
        const user = await userPanel.getUser(owner.address);
        expect(user[0]).to.equal("user1");
        expect(user[1]).to.equal("password1");
    });

    // Kayıtlı olmayan bir kullanıcının bilgilerini getirememesi testi
    it("should not return details of unregistered user", async function () {
        await expect(userPanel.getUser(owner.address)).to.be.revertedWith("Kullanici kayitli degil");
    });
});
