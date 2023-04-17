// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract crowdfunding
{

    mapping(address=>uint) public contributors;
    uint public target;
    uint public deadline;
    uint public raisedAmount;
    uint public noOfContributors;
    uint public minimumContribution;

    constructor(uint _target, uint _deadline){
        target=_target;
        deadline=block.timestamp+_deadline;
        minimumContribution=4000000000000 wei;
    
    }

    function contribute() payable public {
        require(block.timestamp<deadline,"Deadline has passed, you can't contribute");
        require(msg.value>minimumContribution,"You have to donate minimum 4000000000000 wei");


        if(contributors[msg.sender]==0){
            noOfContributors++;
        }


        contributors[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    function refund() public{
        require(block.timestamp>deadline && raisedAmount<target,"you are not elligible for refund");
        require(contributors[msg.sender]>0);
        address payable user =payable(msg.sender);
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;

    }

    struct Campaign{
        string title;
        string description;
        uint value;
    }
    mapping (uint=> Campaign) public campaign;
    uint public numcampaign;