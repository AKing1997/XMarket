// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;
interface ITRC721Receiver {
    function onTRC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}