// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;
interface ITRC721Errors {
    error TRC721InvalidOwner(address owner);
    error TRC721NonexistentToken(uint256 tokenId);
    error TRC721IncorrectOwner(address sender, uint256 tokenId, address owner);
    error TRC721InvalidSender(address sender);
    error TRC721InvalidReceiver(address receiver);
    error TRC721InsufficientApproval(address operator, uint256 tokenId);
    error TRC721InvalidApprover(address approver);
    error TRC721InvalidOperator(address operator);
}