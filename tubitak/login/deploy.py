import json
import os
from solcx import compile_standard,install_solc

from web3 import Web3

from dotenv import load_dotenv

load_dotenv()

install_solc("0.6.0")

with open("./contracts/Login.sol","r") as file:
    simple_storage_file = file.read()
    
compiled_sol = compile_standard(
    {
    "language":"Solidity",
    "sources" : {"Login.sol" : 
                 {
        "content" : simple_storage_file
        }},
    "settings":{
        "outputSelection":{
            "*":{"*" : ["abi","metadata","evm.bytecode","evm.sourceMap"]}
        }
    }
    },
    solc_version="0.6.0",

    

)

with open("compiled_code.json","w") as file:
    json.dump(compiled_sol,file)

# get a bytecode

bytecode = compiled_sol["contracts"]["Login.sol"]["Login"]["evm"]["bytecode"]["object"]

# get a abi

abi = compiled_sol["contracts"]["Login.sol"]["Login"]["abi"]

# for connecting to ganache

w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:7545"))

chain_id = 1337

my_Adress = "0xA5b9A39079aDF98984570B1FF8c6d076d888659f"

private_key = os.getenv("PRIVATE_KEY")



# Create the contract in python

SimpleStorage = w3.eth.contract(abi = abi,bytecode = bytecode)



# Get the latest transaction

nonce = w3.eth.get_transaction_count(my_Adress)



# Build a transaction

# Sign a Transaction

# Send a Transaction

transaction = SimpleStorage.constructor().build_transaction({"chainId":chain_id,"from":my_Adress,"nonce":nonce})



signed_txn = w3.eth.account.sign_transaction(transaction,private_key)



# Send the signed transaction

tx_hash = w3.eth._send_raw_transaction(signed_txn.rawTransaction)



