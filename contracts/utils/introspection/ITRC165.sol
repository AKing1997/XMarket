// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;
interface ITRC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}