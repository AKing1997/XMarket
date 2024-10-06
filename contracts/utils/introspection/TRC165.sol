// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;
import {ITRC165} from "./ITRC165.sol";
abstract contract TRC165 is ITRC165 {
    function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return interfaceId == type(ITRC165).interfaceId;
    }
}