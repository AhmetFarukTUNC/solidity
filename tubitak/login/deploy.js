const HDWalletProvider = require('@truffle/hdwallet-provider');
const {Web3} = require('web3');
const { interface, bytecode } = require('./compile');

const mnemonic = 'hill sing city sweet comic history confirm decline risk capable oxygen unit'; // Metamask veya başka bir cüzdanın mnenomic'i
const infuraUrl = 'https://sepolia.infura.io/v3/c162e17fb4814354bff17441b72e4b3a'; // Infura veya başka bir Ethereum sunucusu URL'si

const provider = new HDWalletProvider(mnemonic, infuraUrl);
const web3 = new Web3(provider);

const deployContract = async () => {
  try {
    const accounts = await web3.eth.getAccounts();
    console.log('Attempting to deploy from account:', accounts[0]);

    // ABI ve bytecode'u kullanarak yeni bir sözleşme instance'ı oluşturun
    const contract = new web3.eth.Contract(interface);

    // Sözleşmeyi ağa deploy edin
    const deployedContract = await contract.deploy({
      data: bytecode,
    }).send({
      from: accounts[0],
      gas: '1000000',
    });

    console.log('Contract deployed to:', deployedContract.options.address);
  } catch (error) {
    console.error('An error occurred during deployment:', error);
  } finally {
    provider.engine.stop();
  }
};

deployContract();
