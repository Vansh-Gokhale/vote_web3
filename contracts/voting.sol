// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract AdvancedVoting {
    address private adminAddress; // Address that can only start the election.
    mapping(address => bool) public voters;
    mapping(uint256 => CandidateInfo) public candidates;
    uint256 public candidateCount;
    bool public isElectionStarted;

    struct CandidateInfo { 
        string name;
        uint voteCount;
    }

    event ElectionStarted();
    event VoteCast(address voter, uint256 candidateId);
    event ElectionEnded(uint256 winnerId, string winnerName, uint256 winnerVotes);

    modifier onlyAdmin() {
        require(msg.sender == adminAddress, "Only admins are allowed to perform this.");
        _;
    }

    modifier electionOngoing() {
        require(isElectionStarted, "Election has not started yet.");
        _;
    }

    modifier hasNotVoted() {
        require(!voters[msg.sender], "You have already voted.");
        _;
    }

    constructor(string[] memory candidateNames) {
        adminAddress = msg.sender;
        candidateCount = candidateNames.length;
        
        for (uint256 i = 0; i < candidateNames.length; i++) {
            candidates[i] = CandidateInfo(candidateNames[i], 0);
        }
    }

    function startElection() external onlyAdmin {
        require(!isElectionStarted, "The election has already started.");
        isElectionStarted = true;
        emit ElectionStarted();
    }

    function vote(uint256 candidateId) external electionOngoing hasNotVoted {
        require(candidateId < candidateCount, "Invalid candidate ID.");
        
        voters[msg.sender] = true;
        candidates[candidateId].voteCount++;
        
        emit VoteCast(msg.sender, candidateId);
    }

    function endElection() external onlyAdmin electionOngoing {
        isElectionStarted = false;
        
        uint256 winnerId = getWinner();
        emit ElectionEnded(winnerId, candidates[winnerId].name, candidates[winnerId].voteCount);
    }

    function getWinner() public view returns (uint256) {
        uint256 winningVoteCount = 0;
        uint256 winningCandidateId = 0;
        
        for (uint256 i = 0; i < candidateCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningCandidateId = i;
            }
        }
        
        return winningCandidateId;
    }

    function getCandidateCount() public view returns (uint256) {
        return candidateCount;
    }

    function getCandidateInfo(uint256 candidateId) public view returns (string memory, uint256) {
        require(candidateId < candidateCount, "Invalid candidate ID.");
        return (candidates[candidateId].name, candidates[candidateId].voteCount);
    }
}