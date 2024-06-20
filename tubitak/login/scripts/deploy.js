const { ethers } = require("hardhat");

async function main() {
    // Deployer hesabını al
    const [deployer] = await ethers.getSigners();
    console.log("Sözleşmeleri bu hesapla dağıtıyoruz:", deployer.address);

    // Hesap bakiyesini yazdır
    const balance = await deployer.getBalance();
    console.log("Hesap bakiyesi:", ethers.utils.formatEther(balance));

    // UserPanel sözleşmesini dağıt
    const UserPanel = await ethers.getContractFactory("UserRegistry");
    const userPanel = await UserPanel.deploy();
    await userPanel.deployed();
    console.log("UserPanel Sözleşme Adresi:", userPanel.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
