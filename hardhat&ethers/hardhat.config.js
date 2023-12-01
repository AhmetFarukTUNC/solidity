    //require("@nomiclabs/hardhat-ethers");
    require("@nomiclabs/hardhat-waffle");

    const PRIVATE_KEY = "1393cc090bf177815c0d343d9562078157dcce6b86344b04a63841c53c2c1596";


    module.exports = {
        solidity: "0.8.20",
        networks: {
          mainnet: {
            url: `https://api.avax.network/ext/bc/C/rpc`,
              accounts: [`${PRIVATE_KEY}`]
          },
          fuji: {
            url: `https://api.avax-test.network/ext/bc/C/rpc`,
              accounts: [`${PRIVATE_KEY}`]
          }
        }
    };