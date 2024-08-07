// SPDX-License-Identifier: MIT

pragma solidity 0.8.26; 

import "./AggregatorInterface.sol";

import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract FundMe {

  using SafeMath for uint256;

  mapping(address => uint256) public addressToAmountFunded;

  address public owner;

  address[] public funders;

  constructor() public {
    owner = msg.sender;
  }

  function fund() public payable {

    uint256 minimumUSD = 50 * 10 * 18;

    require(getConversionRate(msg.value) >= minimumUSD,"You need to spend to ETH!");

    addressToAmountFunded[msg.sender] += msg.value;

    funders.push(msg.sender);

  }

  function getVersion() public view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    return priceFeed.version();
  }

  function getPrice() public view returns(uint256){
     
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

    (,int256 answer,,,) = priceFeed.latestRoundData();

    return uint256(answer* 10000000000);

  }

   function getConversionRate(uint256 ethAmount) public view returns(uint256){

     uint256 ethPrice = getPrice();

     uint256 ethAmountInUsd = (ethPrice*ethAmount) / 1000000000000000000;

     return ethAmountInUsd;

   }

   modifier onlyOwner{
    require(msg.sender == owner);
    _;
   }

   function withdraw() public onlyOwner{
    

     
    

    payable (msg.sender).transfer(address(this).balance);

    for (uint256 funderIndex = 0;funderIndex<funders.length;funderIndex++){

      address funder = funders[funderIndex];


      addressToAmountFunded[funder] = 0;

    }

    funders = new address[](0);

   }

}
