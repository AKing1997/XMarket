// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;

import {RealEstateAsset} from "./RealEstateAsset.sol";
import {RealEstateToken} from "./RealEstateToken.sol";
import {DigitalIdentity} from "./DigitalIdentity.sol";

contract Market {
    DigitalIdentity public digitalIdentity;

    struct Listing {
        uint256 tokenId;
        address seller;
        uint256 price;
    }

    struct SoldAsset {
        uint256 tokenId;
        address buyer;
        uint256 price;
    }

    RealEstateAsset public realEstateNFT;
    RealEstateToken public realEstateToken;
    Listing[] public listings;
    SoldAsset[] public soldAssets;

    event AssetListed(uint256 tokenId, address seller, uint256 price);
    event AssetSold(uint256 tokenId, address buyer, uint256 price);

    constructor(address _realEstateNFT, address _realEstateToken, address digitalIdentity_) {
        digitalIdentity = DigitalIdentity(digitalIdentity_);
        realEstateNFT = RealEstateAsset(_realEstateNFT);
        realEstateToken = RealEstateToken(_realEstateToken);
    }

    function getAllListings() public view returns (Listing[] memory) {
        return listings;
    }

    function getListingById(uint256 index) public view returns (Listing memory) {
        require(index < listings.length, "Index out of range.");
        return listings[index];
    }

    function getAllSoldAssets() public view returns (SoldAsset[] memory) {
        return soldAssets;
    }

    function getSoldAssetById(uint256 index) public view returns (SoldAsset memory) {
        require(index < soldAssets.length, "Index out of range.");
        return soldAssets[index];
    }

    function listAsset(uint256 tokenId, uint256 price) public {
        require(digitalIdentity.isVerified(msg.sender), "Only verified entities can create assets.");
        require(realEstateNFT.ownerOf(tokenId) == msg.sender, "No eres el propietario del activo.");
        require(price > 0, "El precio debe ser mayor que cero.");

        listings.push(Listing({
            tokenId: tokenId,
            seller: msg.sender,
            price: price
        }));

        emit AssetListed(tokenId, msg.sender, price);
    }

    function buyAsset(uint256 listingIndex) public {
        require(digitalIdentity.isVerified(msg.sender), "Only verified entities can create assets.");

        Listing memory listing = listings[listingIndex];
        require(realEstateToken.balanceOf(msg.sender) >= listing.price, "Insufficient funds.");
        
        realEstateNFT.safeTransferFrom(listing.seller, msg.sender, listing.tokenId);
        
        realEstateToken.transferFrom(msg.sender, listing.seller, listing.price);

        emit AssetSold(listing.tokenId, msg.sender, listing.price);
        
        soldAssets.push(SoldAsset({
            tokenId: listing.tokenId,
            buyer: msg.sender,
            price: listing.price
        }));

        removeListing(listingIndex);
    }

    function removeListing(uint256 index) public {
        require(index < listings.length, "Index out of range.");
        require(msg.sender == listings[index].seller, "Only the seller can remove the listing."); 

        listings[index] = listings[listings.length - 1];
        listings.pop();
    }
}
