from brownie import SimpleStorage,accounts

def test_deploy():
    # Arrange
    
    account = accounts[0]

    
    
    # Act
    
    simple_storage = SimpleStorage.deploy({"from":account})

    starting_value = simple_storage.retreive()

    expected = 0

    # Assert

    assert starting_value == expected

def test_updating_storage():
   #Arrange
   
   account = accounts[0]

   #Act

   expected = 15

   simple_storage = SimpleStorage.deploy({"from":account})

   simple_storage.store(expected,{"from":account})

   #Assert

   assert expected == simple_storage.retreive()
 

   