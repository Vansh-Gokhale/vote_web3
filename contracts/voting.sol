// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Voting {
    address public admin;
    bool public electionStarted = false;

    struct Candidate {
        string name;
        uint voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint votedCandidateId;
    }

    Candidate[] public candidates;
    mapping(address => Voter) public voters;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this.");
        _;
    }

    modifier electionOngoing() {
        require(electionStarted, "Election has not started.");
        _;
    }

    constructor(string[] memory candidateNames) {
        admin = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
    }

    function startElection() external onlyAdmin {
        electionStarted = true;
    }

    function endElection() external onlyAdmin {
        electionStarted = false;
    }

    function vote(uint candidateIndex) external electionOngoing {
        require(!voters[msg.sender].hasVoted, "Already voted.");
        require(candidateIndex < candidates.length, "Invalid candidate.");

        voters[msg.sender] = Voter(true, candidateIndex);
        candidates[candidateIndex].voteCount += 1;
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function getWinner() public view returns (string memory winnerName, uint winnerVotes) {
        uint maxVotes = 0;
        uint winnerIndex = 0;
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }
        return (candidates[winnerIndex].name, candidates[winnerIndex].voteCount);
    }
}
