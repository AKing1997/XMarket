// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;

import {Ownable} from "./utils/Ownable.sol";

contract DigitalIdentity is Ownable {
    struct Entity {
        bool isVerified;
        string identifier;
    }

    mapping(address => Entity) public entities;

    event EntityVerified(address indexed entity, string identifier);

    function requestVerification(string memory identifier) public {
        require(!entities[msg.sender].isVerified, "Entity already verified.");
        entities[msg.sender] = Entity(false, identifier);
    }

    function verifyEntity(address entityAddress) public onlyOwner {
        require(!entities[entityAddress].isVerified, "Entity already verified.");

        entities[entityAddress].isVerified = true;

        emit EntityVerified(entityAddress, entities[entityAddress].identifier);
    }

    function isVerified(address entityAddress) public view returns (bool) {
        return entities[entityAddress].isVerified;
    }
}
