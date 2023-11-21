// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// contract A{
//     uint public x;

//     uint public y;

//     function setX(uint _x) virtual public {
//         x =_x;
//     }

//     function setY(uint _y) virtual public {
//         y = _y;
//     }

// }

// // B contract take  

// contract B is A{

//     uint public z;


//     function setZ(uint _z) public {
//         z = _z;
//     }

// // We overwrote the function we inherited.

//     function setX(uint _x) override  public {
//         x = _x +2;
//     }

//     function setY(uint _y) override public {
//         y = _y +3;
//     }




// }

// contract Human{
//     function sayHello() public pure virtual returns(string memory){
//         return "itublockchain.com adresi uzerinden uye olabilirsiniz.";
//     }
// }

// contract SuperHuman is Human{
//     function sayHello() public pure override returns(string memory){
//         return "Selamlar itu blockchain uyesi nasilsin?";
//     }

//     function welcomeMsg(bool isNumber) public pure returns(string memory){
//         return isNumber ? sayHello():Human.sayHello();
//     }
// }

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract Wallet is Ownable{
    constructor()Ownable(msg.sender){}
    fallback() payable external {}
    receive() external payable {}

    function sendEther(address payable to, uint amount) onlyOwner public {
        to.transfer(amount);
    }
    function showBalance() public view returns(uint){
        return address(this).balance;
    }
}