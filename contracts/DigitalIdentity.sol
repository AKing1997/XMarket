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
    event EntityChanged(address indexed entity, string newIdentifier);
    event EntityRemoved(address indexed entity);

    function requestVerification(string memory identifier) public {
        require(!entities[_msgSender()].isVerified, "Entity already verified.");
        require(bytes(identifier).length > 0, "Identifier cannot be empty.");

        entities[_msgSender()] = Entity(false, identifier);
    }

    function verifyEntity(address entityAddress) public onlyOwner {
        require(!entities[entityAddress].isVerified, "Entity already verified.");

        entities[entityAddress].isVerified = true;

        emit EntityVerified(entityAddress, entities[entityAddress].identifier);
    }

    function isVerified(address entityAddress) public view returns (bool) {
        return entities[entityAddress].isVerified;
    }

    function getEntityIdentifier(address entityAddress) public view returns (string memory) {
        require(entities[entityAddress].isVerified || bytes(entities[entityAddress].identifier).length > 0, "Entity does not exist.");
        return entities[entityAddress].identifier;
    }

    function changeEntity(string memory newIdentifier) public {
        require(bytes(newIdentifier).length > 0, "New identifier cannot be empty.");
        require(bytes(entities[_msgSender()].identifier).length > 0, "Entity does not exist.");
        
        entities[_msgSender()].identifier = newIdentifier;
        emit EntityChanged(_msgSender(), newIdentifier);
    }

    function removeEntity() public {
        require(bytes(entities[_msgSender()].identifier).length > 0, "Entity does not exist.");

        delete entities[_msgSender()];
        emit EntityRemoved(_msgSender());
    }
}
