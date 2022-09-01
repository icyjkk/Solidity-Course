// SPDX-License-Identifier: MIT

// Smart contract that lets anyone deposit ETH into the contract
// Only the owner of the contract can withdraw the ETH
pragma solidity >=0.6.6 <0.9.0;


import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol"; // Get the latest ETH/USD price from chainlink price feed
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public addressToAmountFunded; //mapping to store which address depositeded how much ETH
    address[] public funders; 
    address public owner;

    constructor() public {      //constructor execute when contract deploy
        owner = msg.sender;     // msg.sender is who deploy contract
    }

    function fund() public payable {  //specifically, payable with eth/ethereum
        //50$
        uint256 minimunUSD = 50 * 10 ** 18;                 // to ensure it have 18 decimals

        //if(msg.value < minimumUSD ){revert?}
        // 1gwei < $50
        require(getConversionRate(msg.value) >= minimunUSD, "You need to spend more ETH!");    //if not true function stop

        addressToAmountFunded[msg.sender] +=msg.value;     // msg.sender is the person who has called the function and msg.value is how much they have sent
        funders.push(msg.sender);

    }

    //function to get the version of the chainlink pricefeed
    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);    //https://docs.chain.link/docs/ethereum-addresses/
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData(); 
        return uint256(answer * 10000000000);   // it will return the price with eighteen decimal instead of 10
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount)/ 1000000000000000000;
        return ethAmountInUsd;
    }

    modifier onlyOwner {                //modifier execute before function 
        require(msg.sender == owner);   
        _;                              //it execute code
    }

    function withdraw() payable onlyOwner public {
        //only want the contract admin/owner
        msg.sender.transfer(address(this).balance);

        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){        //to reset the mapping and array
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }

}