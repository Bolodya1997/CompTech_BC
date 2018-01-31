pragma solidity ^0.4.16;

contract Voting {
    struct Votation {
        uint id;
        string title;
        string description;
        string options;
        address wallet_autor;
        uint begin;
        uint timeout;
        bool active;
        bool end;
    }

    uint curr_id = 1;    
    mapping(uint => Votation) public votations;
    mapping(uint => mapping(address => uint)) public votes;

    function CreateVotation(string title, string description, string options, uint begin, uint timeout) 
    public
    returns (uint) {
        uint id = curr_id++;
        Votation storage votation = votations[id];
        votation.id = id;
        votation.title = title;
        votation.description = description;
        votation.wallet_autor = msg.sender;
        votation.active = true;
        votation.end = false;
        votation.options = options;
        votation.begin = begin;
        votation.timeout = timeout;

        return id;
    }

    function Vote(uint votation_id, uint option_id) 
    public {
        require(votes[votation_id][msg.sender] == 0);
        votes[votation_id][msg.sender] = option_id;
    }
}