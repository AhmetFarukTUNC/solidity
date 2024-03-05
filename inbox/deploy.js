const HDWalletProvider = require("@truffle/hdwallet-provider");

const Web3 = require("web3");

const {interface,bytecode} = require("./compile");

const provider = new HDWalletProvider(
    "major radio attack shed fatigue seven car element cancel rich unit metal",

    "https://sepolia.infura.io/v3/c162e17fb4814354bff17441b72e4b3a"
);

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();

    console.log("Attempting to deploy from account",accounts[0]);

    const result = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({data:bytecode,arguments:["Hi,there!"]})
    .send({gas:"5",from:accounts[0]});

    console.log("Contract deployed to", result.options.address);

    provider.engine.stop();



};

deploy();

