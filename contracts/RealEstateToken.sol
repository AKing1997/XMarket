// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;
import {TRC20} from "./trc20/TRC20.sol";

contract RealEstateToken is TRC20 {
    uint256 private constant INITIAL_SUPPLY = 1000000 * (10 ** 18);
    constructor(address digitalIdentity_) TRC20("RealEstateToken", "RET", 18, digitalIdentity_) {
        _mint(msg.sender, INITIAL_SUPPLY);
    }
}
