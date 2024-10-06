// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;

import {TRC721} from "./trc721/TRC721.sol";
import {DigitalIdentity} from "./DigitalIdentity.sol";

contract RealEstateAsset is TRC721 {
    DigitalIdentity public digitalIdentity;

    struct Asset {
        string name;
        string location;
        uint256 value;
    }

    mapping(uint256 => Asset) public assets;
    uint256 public nextTokenId;

    event AssetCreated(uint256 tokenId, string name, string location, uint256 value);

    modifier onlyVerified(address from, address to) {
        require(digitalIdentity.isVerified(from), "The owner must be verified.");
        require(digitalIdentity.isVerified(to), "The recipient must be verified.");
        _;
    }

    constructor(address digitalIdentity_) TRC721("RealEstateAsset", "REA") {
        digitalIdentity = DigitalIdentity(digitalIdentity_);
    }

    function createAsset(string memory name, string memory location, uint256 value) public {
        require(digitalIdentity.isVerified(msg.sender), "Only verified entities can create assets.");
        
        uint256 tokenId = nextTokenId++;
        assets[tokenId] = Asset(name, location, value);
        _mint(msg.sender, tokenId); // Esto debería funcionar ahora
        
        emit AssetCreated(tokenId, name, location, value);
    }
    
    function transferFrom(address from, address to, uint256 tokenId) public override onlyVerified(from, to) {
        super.transferFrom(from, to, tokenId);
    }

        function safeTransferFrom(address from, address to, uint256 tokenId) public override onlyVerified(from, to) {
        super.safeTransferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public override onlyVerified(from, to) {
        super.safeTransferFrom(from, to, tokenId, data);
    }
}