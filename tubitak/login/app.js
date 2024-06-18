// Web3 sağlayıcısını kontrol edin (Metamask gibi)
if (typeof window.ethereum !== 'undefined') {
    window.web3 = new Web3(window.ethereum);

    // Akıllı sözleşme adresi ve abi'si
    const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3"; // Sözleşme adresini buraya girin
    const abi = [
      {
        "anonymous": false,
        "inputs": [
          {
            "indexed": true,
            "internalType": "address",
            "name": "user",
            "type": "address"
          },
          {
            "indexed": false,
            "internalType": "string",
            "name": "username",
            "type": "string"
          }
        ],
        "name": "UserRegistered",
        "type": "event"
      },
      {
        "inputs": [],
        "name": "getAllUsers",
        "outputs": [
          {
            "internalType": "address[]",
            "name": "",
            "type": "address[]"
          }
        ],
        "stateMutability": "view",
        "type": "function"
      },
      {
        "inputs": [
          {
            "internalType": "address",
            "name": "userAddress",
            "type": "address"
          }
        ],
        "name": "getUser",
        "outputs": [
          {
            "internalType": "string",
            "name": "",
            "type": "string"
          },
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
        "inputs": [
          {
            "internalType": "string",
            "name": "username",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "password",
            "type": "string"
          }
        ],
        "name": "registerUser",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "inputs": [
          {
            "internalType": "address",
            "name": "userAddress",
            "type": "address"
          },
          {
            "internalType": "string",
            "name": "newUsername",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "newPassword",
            "type": "string"
          }
        ],
        "name": "updateUser",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      }
   ]

    // Sözleşme nesnesini oluştur
    const contract = new web3.eth.Contract(abi, contractAddress);
    console.log(contract.methods.getAllUsers().call())

    // Kullanıcı kaydı formunu dinle
    document.getElementById("registerForm").addEventListener("submit", async function(event) {
        event.preventDefault();

        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;

        try {
            // Metamask veya diğer sağlayıcı ile hesap seçimi yapın
            const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
            const userAddress = accounts[0];

            // Kullanıcıyı kaydet
            await contract.methods.registerUser(username, password)
                .send({ from: userAddress })
                .on("transactionHash", function(hash) {
                    console.log("Transaction hash:", hash);
                })
                .on("receipt", function(receipt) {
                    console.log("Transaction receipt:", receipt);
                    alert("User registered successfully!");
                    
                })
                .on("error", function(error) {
                    console.error("Error:", error);
                    alert("Error registering user!");
                });

            // Başarılı kayıt sonrası formu temizle
            document.getElementById("username").value = "";
            document.getElementById("password").value = "";

        } catch (error) {
            console.error("Error:", error);
            alert("Error registering user!");
        }
    });
    // Tüm kullanıcı adreslerini almak için fonksiyon

   

  }


