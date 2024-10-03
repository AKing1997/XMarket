// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;
import {ITRC20} from "./ITRC20.sol";
interface ITRC20Metadata is ITRC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}