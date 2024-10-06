// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;

library SignedMath {
    function abs(int256 n) internal pure returns (uint256) {
        unchecked {
            int256 mask = n >> 255;
            return uint256((n + mask) ^ mask);
        }
    }
}