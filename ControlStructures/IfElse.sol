//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;

contract IfElse {
    bytes32 private hashedPassword;

    uint256 private loginCount;

    constructor(string memory _password){
        hashedPassword =keccak256(abi.encode(_password));
    }

    //This is a function for user login page.

    function login(string memory _password)  public view  returns(bool){
        if(hashedPassword == keccak256(abi.encode(_password))){

            return true;

            

        }
        else{
            return false;
        }
    }

    function login2(string memory _password2)  public returns(uint){
        if(hashedPassword == keccak256(abi.encode(_password2))){
            loginCount++;
            return 1;
            

        }

        else{
            return 0;
        }
    }

    //This is a condition structure but this is in a row.

    function login3(string memory _password3) public view returns(uint){
        return hashedPassword==keccak256(abi.encode(_password3))?1:0;
    }

    //Thi sis a function for login status.

    function loginStatus() public view returns(uint){

         if(loginCount==0){
            return 0;
         }

         else if(loginCount==1){
            return 1;
         }
         else{
            return 2;
         }
    }

    


}