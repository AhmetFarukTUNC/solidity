// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
contract Bank{
    mapping(address=>uint) balances;

    function sendEtherToContract() payable external{
 
        balances[msg.sender] = msg.value; //This function send ether because this function is payable.

    }

    function showBalance() external view returns(uint){

       return balances[msg.sender];//return balance

    }

    function withDraw(address payable to,uint amount) external{
        require(balances[msg.sender] >= amount,"Yetersiz bakiye");
        to.transfer(amount); // Money return to my account from wallet.
        balances[msg.sender] -= amount;
    }

    //Transfer function send monet to wallet or other account and return revert message for this operation.
    // if operation completes send function returns true and else returns false.
    // Call function returns fact for send ether and message.

    uint public receiveCount = 0;

    uint public fallbackCount = 0;

    // This function increase one with receive keyword.

    receive() external payable {
        receiveCount += 1;
     }

    //Fallback function provides send data with ether.

    fallback() external payable { 

       fallbackCount += 1;

    }

        

}