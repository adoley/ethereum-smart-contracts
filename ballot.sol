pragma solidity ^0.4.0;
/*
 * Smart contract to conduct election.
 * Here the Election Commisioner deploy the smart contract
 * Election Commisioner add the voters
 * Election Commisioner add the condidates contesting the election
 * General voters can only vote once 
 * Everyone can see how many votes a candidate have received
 * Election Commisioner can view Voters,Candidates, number of Voters and number of Candidates
*/
contract Ballot {
    address private electionCommisioner;
    mapping(address => bool) private voters;
    mapping(address => uint256) private candidates;
    address[] private voterList;
    address[] private candidateList;
    
    //Election Commisioner is set through constructor
    function Ballot() public{
       electionCommisioner=msg.sender; 
    }
    
    modifier onlyElectionCommisioner{
        require(msg.sender==electionCommisioner);
        _;
    }
    
    //Election Commisioner is adding voter. Only Election Commisioner can add voter and this is 
    //achieved by using onlyElectionCommisioner modifier.
    function addVoters(address voter) onlyElectionCommisioner public{
        voters[voter]=false;
        voterList.push(voter) -1;
    }
    
    //Election Commisioner is adding candidate who is contesting the election. Only Election Commisioner
    //can add candidate and this is  achieved by using onlyElectionCommisioner modifier.
    function setCandidates(address candidate) onlyElectionCommisioner public{
        candidates[candidate]=0;
        candidateList.push(candidate) -1;
    }
    
    //General voters can only vote once 
    function vote(address candidate) public returns (string response){
        bool voted=voters[msg.sender];
        
        if(!voted){
            voters[msg.sender]=true;
            uint256 numberOfVotes=candidates[candidate];
            candidates[candidate]=numberOfVotes+1;
            response="voted succesfully";
        }else{
            response="already voted, you are not allowed to vote more than once";
        }
    }
    
    //Everyone can see how many votes a candidate have received
    function numberOfVotes(address candidate) public view returns (uint256 votes){
        votes=candidates[candidate];
    }
    
    //Only Election Commisioner can view number of voters
    function numberOfVoters() onlyElectionCommisioner public view returns(uint256 _numberOfVoters){
        _numberOfVoters=voterList.length;
    }
    //Only Election Commisioner can view voters
    function getVoters() onlyElectionCommisioner public view returns(address[]){
        return voterList;
    }
    
    //Only Election Commisioner can view number of candidates contesting the election
    function numberOfCandidates() onlyElectionCommisioner public view returns(uint256 _numberOfCandidates){
        _numberOfCandidates=candidateList.length;
    }
    //Only Election Commisioner can view candidates
    function getCandidates() onlyElectionCommisioner public view returns(address[]){
        return candidateList;
    }
}
