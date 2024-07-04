import json
import os
from solcx import compile_standard, install_solc
from web3 import Web3
from dotenv import load_dotenv

load_dotenv()

install_solc("0.6.0")

with open("./SimpleStorage.sol", "r") as file:
    simple_storage_file = file.read()

compiled_sol = compile_standard(
    {
        "language": "Solidity",
        "sources": {"SimpleStorage.sol": {"content": simple_storage_file}},
        "settings": {
            "outputSelection": {
                "*": {"*": ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]}
            }
        },
    },
    solc_version="0.6.0",
)

with open("compiled_code.json", "w") as file:
    json.dump(compiled_sol, file)

# get a bytecode
bytecode = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["evm"]["bytecode"]["object"]

# get a abi
abi = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["abi"]

# for connecting to ganache
w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))

chain_id = 1337
my_Adress = "0x9855430248e3c03eC273dc40Ee4031577e4A10Ba"
private_key = os.getenv("PRIVATE_KEY")

# Create the contract in python
SimpleStorage = w3.eth.contract(abi=abi, bytecode=bytecode)

# Get the latest transaction
nonce = w3.eth.get_transaction_count(my_Adress)

# Build a transaction
transaction = SimpleStorage.constructor().build_transaction({
    "chainId": chain_id,
    "from": my_Adress,
    "nonce": nonce,
    "gas": 2000000,  # You can adjust this as necessary
    "gasPrice": w3.to_wei('20', 'gwei')  # Set a gas price
})

# Sign a Transaction
signed_txn = w3.eth.account.sign_transaction(transaction, private_key)

# Send the signed transaction
tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)

tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)

# Working with the contract, you always need
# Contract address
# Contract ABI
simple_storage = w3.eth.contract(address=tx_receipt.contractAddress, abi=abi)

# Initial value of favourite number
print(simple_storage.functions.retreive().call())

# Update the value of the favourite number
store_transaction = simple_storage.functions.store(15).build_transaction({
    "chainId": chain_id,
    "from": my_Adress,
    "nonce": nonce + 1,
    "gas": 2000000,  # You can adjust this as necessary
    "gasPrice": w3.to_wei('20', 'gwei')  # Set a gas price
})

signed_store_txn = w3.eth.account.sign_transaction(store_transaction, private_key=private_key)

send_store_tx = w3.eth.send_raw_transaction(signed_store_txn.rawTransaction)

tx_receipt = w3.eth.wait_for_transaction_receipt(send_store_tx)

print(simple_storage.functions.retreive().call())
