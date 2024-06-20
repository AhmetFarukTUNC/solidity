// Web3.js kullanarak Ethereum ağına bağlanma işlemleri burada gerçekleştirilecek
window.addEventListener('load', async () => {
    if (window.ethereum) {
        window.web3 = new Web3(window.ethereum);
        try {
            // Kullanıcının Ethereum hesabınızı bağlayın
            await window.ethereum.enable();

            // Akıllı kontrat adresi ve ABI
            const contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
            
            // HititCoin kontratının adresini buraya yazın
            
            const response = await fetch('./artifacts/contracts/HititCoin.sol/HititCoin.json');
            const contractJson = await response.json();
            const contractABI = [
              {
                  "inputs": [
                      {
                          "internalType": "uint256",
                          "name": "initialSupply",
                          "type": "uint256"
                      }
                  ],
                  "stateMutability": "nonpayable",
                  "type": "constructor"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "spender",
                          "type": "address"
                      },
                      {
                          "internalType": "uint256",
                          "name": "allowance",
                          "type": "uint256"
                      },
                      {
                          "internalType": "uint256",
                          "name": "needed",
                          "type": "uint256"
                      }
                  ],
                  "name": "ERC20InsufficientAllowance",
                  "type": "error"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "sender",
                          "type": "address"
                      },
                      {
                          "internalType": "uint256",
                          "name": "balance",
                          "type": "uint256"
                      },
                      {
                          "internalType": "uint256",
                          "name": "needed",
                          "type": "uint256"
                      }
                  ],
                  "name": "ERC20InsufficientBalance",
                  "type": "error"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "approver",
                          "type": "address"
                      }
                  ],
                  "name": "ERC20InvalidApprover",
                  "type": "error"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "receiver",
                          "type": "address"
                      }
                  ],
                  "name": "ERC20InvalidReceiver",
                  "type": "error"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "sender",
                          "type": "address"
                      }
                  ],
                  "name": "ERC20InvalidSender",
                  "type": "error"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "spender",
                          "type": "address"
                      }
                  ],
                  "name": "ERC20InvalidSpender",
                  "type": "error"
              },
              {
                  "anonymous": false,
                  "inputs": [
                      {
                          "indexed": true,
                          "internalType": "address",
                          "name": "owner",
                          "type": "address"
                      },
                      {
                          "indexed": true,
                          "internalType": "address",
                          "name": "spender",
                          "type": "address"
                      },
                      {
                          "indexed": false,
                          "internalType": "uint256",
                          "name": "value",
                          "type": "uint256"
                      }
                  ],
                  "name": "Approval",
                  "type": "event"
              },
              {
                  "anonymous": false,
                  "inputs": [
                      {
                          "indexed": true,
                          "internalType": "address",
                          "name": "from",
                          "type": "address"
                      },
                      {
                          "indexed": true,
                          "internalType": "address",
                          "name": "to",
                          "type": "address"
                      },
                      {
                          "indexed": false,
                          "internalType": "uint256",
                          "name": "value",
                          "type": "uint256"
                      }
                  ],
                  "name": "Transfer",
                  "type": "event"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "owner",
                          "type": "address"
                      },
                      {
                          "internalType": "address",
                          "name": "spender",
                          "type": "address"
                      }
                  ],
                  "name": "allowance",
                  "outputs": [
                      {
                          "internalType": "uint256",
                          "name": "",
                          "type": "uint256"
                      }
                  ],
                  "stateMutability": "view",
                  "type": "function"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "spender",
                          "type": "address"
                      },
                      {
                          "internalType": "uint256",
                          "name": "value",
                          "type": "uint256"
                      }
                  ],
                  "name": "approve",
                  "outputs": [
                      {
                          "internalType": "bool",
                          "name": "",
                          "type": "bool"
                      }
                  ],
                  "stateMutability": "nonpayable",
                  "type": "function"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "account",
                          "type": "address"
                      }
                  ],
                  "name": "balanceOf",
                  "outputs": [
                      {
                          "internalType": "uint256",
                          "name": "",
                          "type": "uint256"
                      }
                  ],
                  "stateMutability": "view",
                  "type": "function"
              },
              {
                  "inputs": [],
                  "name": "decimals",
                  "outputs": [
                      {
                          "internalType": "uint8",
                          "name": "",
                          "type": "uint8"
                      }
                  ],
                  "stateMutability": "view",
                  "type": "function"
              },
              {
                  "inputs": [],
                  "name": "name",
                  "outputs": [
                      {
                          "internalType": "string",
                          "name": "",
                          "type": "string"
                      }
                  ],
                  "stateMutability": "view",
                  "type": "function"
              },
              {
                  "inputs": [],
                  "name": "symbol",
                  "outputs": [
                      {
                          "internalType": "string",
                          "name": "",
                          "type": "string"
                      }
                  ],
                  "stateMutability": "view",
                  "type": "function"
              },
              {
                  "inputs": [],
                  "name": "totalSupply",
                  "outputs": [
                      {
                          "internalType": "uint256",
                          "name": "",
                          "type": "uint256"
                      }
                  ],
                  "stateMutability": "view",
                  "type": "function"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "to",
                          "type": "address"
                      },
                      {
                          "internalType": "uint256",
                          "name": "value",
                          "type": "uint256"
                      }
                  ],
                  "name": "transfer",
                  "outputs": [
                      {
                          "internalType": "bool",
                          "name": "",
                          "type": "bool"
                      }
                  ],
                  "stateMutability": "nonpayable",
                  "type": "function"
              },
              {
                  "inputs": [
                      {
                          "internalType": "address",
                          "name": "from",
                          "type": "address"
                      },
                      {
                          "internalType": "address",
                          "name": "to",
                          "type": "address"
                      },
                      {
                          "internalType": "uint256",
                          "name": "value",
                          "type": "uint256"
                      }
                  ],
                  "name": "transferFrom",
                  "outputs": [
                      {
                          "internalType": "bool",
                          "name": "",
                          "type": "bool"
                      }
                  ],
                  "stateMutability": "nonpayable",
                  "type": "function"
              }
          ];



            
              
               
            
            

            // Web3 ile kontratı yükleme
            const contract = new web3.eth.Contract(contractABI, contractAddress);

            // Kullanıcının Ethereum adresini alın
            const accounts = await web3.eth.getAccounts();
            const userAddress = accounts[0];

            // Kontrattan kullanıcının bakiyesini alın
            const balance = await contract.methods.balanceOf(userAddress).call();
            console.log("Balance:", balance);

            // HTML sayfasında bakiyeyi gösterme
            document.getElementById('balance').textContent = balance.toString();

        } catch (error) {
            console.error(error);
        }
    } else {
        console.error("Web3 not found. Please install MetaMask.");
    }
});