
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Fundme{

    uint256  minimumUsd=5*1e18;
    address [] public funders;
    mapping(address=>uint256)public addressToAmountFunded;

   function fund()public payable{

      require(getConversionRate(msg.value)>=minimumUsd,"Did't send enough!");
       funders.push(msg.sender);
       addressToAmountFunded[msg.sender]=msg.value;
   }

   function getPrice() public view  returns(uint256){
     AggregatorV3Interface a1=  AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

    (, int price,,,) =a1.latestRoundData();
   
    return uint256((price)*1e10);
   }

   function getConversionRate(uint256 ethAmount) public view returns(uint256) {
      uint256 ethPrice=getPrice();
      uint256 ethAmountInUsd=(ethPrice*ethAmount)/1e18;
      return ethAmountInUsd;
       

   }

   



}
