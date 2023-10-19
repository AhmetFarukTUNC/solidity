// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
//Smart contract names starts with big letter. =>This is a comment line.
contract Variables{
   //Fixed Size Types

   bool isTrue = true;

   bool isfalse = false;

   bool isTrue2;
   bool isFalse2;

   // integer variables

   int number = 18; // -2^256.................2^256

   int8 number2 = 36; // -2^8....................2^8

   uint number3=123; //0............2^256

   address address1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; //It keeps etherium wallet addresses.

   bytes name1 = "Ahmet"; // Bytes data type keeps as hexadecimal.

   string name2 ="Ahmet";

   //Dynamic Size Types(arrays,mapping)

   uint[] array = [1,2,3,4,5];

   mapping(uint => string) list; // uint keeps to string value and variable name is list.

   //User Defined Value Types

   struct Human{
      uint ID;
      string name;
      uint age;
      address adres;
   }

   mapping(uint=>Human) list2;

   Human person1;

   enum traficLight{
      RED,
      YELLOW,
      GREEN
   }
   
   //ONE ETHER İS 10^18 WEİ.This is equal to 1000000000000000000.
   //One gweiis equal to 10^9.
   // 1second = 1
   //1 minute = 60 seconds
   //1 hour = 60 minutes = 3600 seconds 

   //scopes
   // State variables is a in contract.
   string public bestClub = "Tunc Academy";

   function show() public pure returns(uint){
      // you can use variable here local variables.

      //return bestClub;
      uint number4 = 17;

      return number4;
      
     
   }

   function show2() public view returns(string memory){
      return bestClub;
   }

   function show3() public view returns (address){
      return msg.sender;
      
   }



   


}

