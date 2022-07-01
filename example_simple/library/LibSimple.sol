// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ISimple} from "../interface/ISimple.sol";

library LibSimple {
    bytes32 private constant _STORAGE_POSITION =
        keccak256("facet.simple.storage");

    /** ***** ***** ***** ***** *****
     * struct
     ***** ***** ***** ***** ***** */
    struct SimpleStorage {
        uint256 value;
    }

    /** ***** ***** ***** ***** *****
     * private function
     ***** ***** ***** ***** ***** */
    function _storage() private pure returns (SimpleStorage storage s) {
        bytes32 position = _STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    /** ***** ***** ***** ***** *****
     * internal function
     ***** ***** ***** ***** ***** */
    function set(uint256 _val) internal returns (bool) {
        _storage().value = _val;
        return true;
    }

    function get() internal view returns (uint256) {
        return _storage().value;
    }
}
