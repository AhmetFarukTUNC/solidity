// SPDX-License-Identifier: MIT
import { expect } from 'chai';
import { ethers } from 'hardhat';

describe("UserPanel Contract", function () {
    let owner, user1;
    let UserPanel, userPanel;

    before(async function () {
        [owner, user1] = await ethers.getSigners();

        UserPanel = await ethers.getContractFactory("UserPanel");
        userPanel = await UserPanel.connect(owner).deploy();
    });

    it("UserPanel kontratı deploy edilir", async function () {
        expect(userPanel.address).to.not.be.undefined;
    });

    it("Yeni bir kullanıcı kaydeder", async function () {
        await userPanel.connect(user1).registerUser("alice", "password123");

        const [username, password] = await userPanel.getUser(user1.address);
        expect(username).to.equal("alice");
        expect(password).to.equal("password123");
    });

    it("Zaten kayıtlı bir kullanıcıyı kaydetmeyi deneyin", async function () {
        await expect(userPanel.connect(user1).registerUser("alice", "newpassword")).to.be.revertedWith("Kullanici zaten kayitli");
    });

    it("Tüm kayıtlı kullanıcıları alır", async function () {
        const allUsers = await userPanel.getAllUsers();
        expect(allUsers).to.deep.equal([user1.address]);
    });

    it("Kullanıcı bilgilerini günceller", async function () {
        await userPanel.connect(user1).updateUser(user1.address, "alice_updated", "newpassword");

        const [username, password] = await userPanel.getUser(user1.address);
        expect(username).to.equal("alice_updated");
        expect(password).to.equal("newpassword");
    });
});
