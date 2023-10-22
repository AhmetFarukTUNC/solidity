//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;

contract Loops{

    uint256[15] public numbers1;

    uint256[15] public numbers2;

    bool public state = false;

    uint256 public num;

    function createListWithForLoop() public {
        uint256[15] memory nums = numbers1;
        
        for(uint256 i = 0; i < nums.length;i++){
            if (i==9) {
                break;
            }
            nums[i] = i;  
             
        }

        numbers1 = nums;

        

    }

    function getNumbers1() public view returns(uint256[15] memory){
        return numbers1;
    }

    function listByWhile() public {
        uint256 i = 0;
        while (i<numbers2.length) 
        {
           numbers2[i] = i;
           i++;   
        }
    }

    function getNumbers2() public view returns(uint256[15] memory){
        return numbers2;
    }

    function crashByWhile() public {
        while (!state) 
        {
            num++;
            num--;
        }
    }

}