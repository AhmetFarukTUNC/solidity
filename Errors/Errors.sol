// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract  Errors{

    uint256 public totalBalance;

    mapping(address=>uint256) public userBalances;

    error ExceedingAmount(address user,uint256 exceedingAmount);

    error Deny(string Reason);

    receive() external payable {
        revert Deny("No direct payments.");
     }

    fallback() external payable {

       revert Deny("No direct payments.");

     }

    function pay() external payable  noZero(msg.value){
          require(msg.value == 1 ether,"Only payments in 1 ether");

          totalBalance += 1 ether;

          userBalances[msg.sender] += 1 ether;
    }

    function withDraw(uint256 _amount)external {
        uint256 initialBalance = totalBalance;
        if (userBalances[msg.sender] < _amount) {
            revert ExceedingAmount(msg.sender,_amount - userBalances[msg.sender]);
        }

        totalBalance -= _amount;

        userBalances[msg.sender] -= _amount;

        //here we tranfered  ether to main account.

        payable(msg.sender).transfer(_amount);
        
        assert(totalBalance<initialBalance );


        

    }

    modifier noZero(uint256 _amount){
        
        require(_amount != 0,"Not Valid");
        
        _;
    }
    
}