// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;
library SafeCast {
    function toUint(bool b) internal pure returns (uint256 u) {
        assembly ("memory-safe") {
            u := iszero(iszero(b))
        }
    }
}