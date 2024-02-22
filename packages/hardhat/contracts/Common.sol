// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

 struct Campaingn {
        uint256 Id;
        string Name;
        string Description;
        uint256 Goal;
        address payable DepositAddress;
        bool Open;
    }