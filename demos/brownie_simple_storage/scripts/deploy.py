
import os
from brownie import accounts,config,SimpleStorage,network

def deploy_simple_storage():
    # Way 1
    # account = accounts.load("account1")
    # print(account)

    # Way 2
    # account = accounts.add(os.getenv("PRIVATE_KEY"))
    # print(account)
    

    # Way 3
    # account = accounts.add(config["wallets"]["from_key"])
    # print(account)

    # Way 4

    # account = accounts[0]

    # print(account)

    account = get_account()

    simple_storage = SimpleStorage.deploy({"from":account})

    print(simple_storage)

    stored_value = simple_storage.retreive()

    print(stored_value)

    transaction = simple_storage.store(15,{"from":account})

    print(transaction)

    transaction.wait(1)

    updated_stored_value = simple_storage.retreive()

    print(updated_stored_value)

def get_account():
    if network.show_active() == "devolopment":
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])

def main():
    deploy_simple_storage()