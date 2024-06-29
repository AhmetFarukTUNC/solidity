// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Overflow {
    function overflow() public view returns (uint256) {
        uint256 big = 255 + uint256(100); // No overflow occurs with uint256

        return big;
    }
}
