// SPDX-License-Identifier: MIT
// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

pragma solidity ^0.8.20;

import {Campaingn} from './Common.sol';

contract CrowdFund {
    error CampaingnNotFound();
    error Insufficient_Balance();
    error Decimals_Exceeded();
    error Transfer_Failed();

    address public owner;
    Campaingn[] private CampaingnList;
    mapping(uint256 => Campaingn) private CampaingnMapping;
    mapping(uint256 Id => uint256 Deposits) private CampaingnDeposits;
    uint256 private lastId;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event paidCampaign(address indexed reciever, uint256 amountPaid);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        lastId = 0;
        owner =  0x90139066A44A0eD1E335CA08fdC0218eaE8D7C7f; // Set the owner in the constructor
        //owner = msg.sender; // Set the owner in the constructor
    }

    function fundCampaign(uint256 id) public payable returns (bool) {
        //find the campaign
        Campaingn memory receiveingCamp = CampaingnMapping[id];
        if (receiveingCamp.Id == 0) {
            revert CampaingnNotFound();
        }
        if (msg.value == 0) {
            revert Insufficient_Balance();
        }
        CampaingnDeposits[id] += msg.value;
        return true;
    }

    function CreateCampaign(
        string memory name,
        string memory description,
        uint256 goal,
        address payable depositAddress
    ) external returns (bool) {
        uint256 id = incrementandReturnId();

        Campaingn memory campaign = Campaingn(lastId, name, description, goal, depositAddress, true);
        CampaingnList.push(campaign);
        CampaingnMapping[id] = campaign;
        CampaingnDeposits[id] = 0;
        return true;
    }

     function payCampaign(uint256 id) public payable returns (bool) {
        Campaingn memory receiveingCamp = CampaingnMapping[id];
        if (receiveingCamp.Id == 0) {
            revert CampaingnNotFound();
        }
        uint256 depositedAmt = CampaingnDeposits[id];
        if (address(this).balance <= depositedAmt) {
            revert Insufficient_Balance();
        }
        //receiveingCamp.DepositAddress.transfer(depositedAmt);
        address receiver= receiveingCamp.DepositAddress;
          (bool sent, bytes memory data) = payable(receiver).call{value: depositedAmt}("");
        emit paidCampaign(receiveingCamp.DepositAddress, depositedAmt);
        if(!sent){
            revert Transfer_Failed();
        }
        CampaingnDeposits[id]=0;
        return true;
    }

    function getCampaignDeposit(uint256 id) external view returns (uint256) {
        return CampaingnDeposits[id];
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function GetCampaigns() external view returns (Campaingn[] memory) {
        return CampaingnList;
    }

    function GetCampaingnLength() public view returns (uint256) {
        return CampaingnList.length;
    }

    function GetCampaingn(uint256 id) public view returns (Campaingn memory) {
        return CampaingnMapping[id];
    }

    function GetLastId() public view returns (uint256) {
        return lastId;
    }

    function incrementandReturnId() private returns (uint256) {
        lastId++;
        return lastId;
    }

 
}


