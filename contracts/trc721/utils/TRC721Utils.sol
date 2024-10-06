// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;
import {ITRC721Receiver} from "./../interfaces/ITRC721Receiver.sol";
import {ITRC721Errors} from "./../interfaces/ITRC721Errors.sol";

library TRC721Utils {
    function checkOnTRC721Received(
        address operator,
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) internal {
        if (to.code.length > 0) {
            try ITRC721Receiver(to).onTRC721Received(operator, from, tokenId, data) returns (bytes4 retval) {
                if (retval != ITRC721Receiver.onTRC721Received.selector) {
                    revert ITRC721Errors.TRC721InvalidReceiver(to);
                }
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert ITRC721Errors.TRC721InvalidReceiver(to);
                } else {
                    assembly ("memory-safe") {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        }
    }
}