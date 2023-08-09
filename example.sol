// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageContract {
    string public message;
    bytes32 public merkleRoot;

     event MessageSubmitted(string user, string message);

    function submitMessage(string memory _user, string memory _message) public {
        emit MessageSubmitted(_user, _message);
    }

    event MessageUpdated(string newMessage);

    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
    }

    function updateMessage(string memory _newMessage) public {
        require(verifyProof(_newMessage), "Invalid proof");
        message = _newMessage;
        emit MessageUpdated(_newMessage);
    }

    function verifyProof(string memory _newMessage) public view returns (bool) {
        // This is a simplified example, in a real scenario, you would perform proper Merkle proof verification here
        // Compare the hash of the new message with the root hash stored in the contract
        return keccak256(abi.encodePacked(_newMessage)) == merkleRoot;
    }
}
