// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "./LibDiamond.sol";

library LibOwnable {
    /// @dev storage position
    bytes32 constant private _STORAGE_POSITION = keccak256("facet.ownable.storage");

    /** ***** ***** ***** ***** *****
     * struct
     ***** ***** ***** ***** ***** */
    struct OwnableStorage {
        bool initized;
        address owner;
    }

    /** ***** ***** ***** ***** *****
     * event
     ***** ***** ***** ***** ***** */
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /** ***** ***** ***** ***** *****
     * private function
     ***** ***** ***** ***** ***** */
    function _storage() private pure returns (OwnableStorage storage s) {
        bytes32 position = _STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    /** ***** ***** ***** ***** *****
     * init function
     ***** ***** ***** ***** ***** */
    function init(address _newOwner) internal {
        OwnableStorage storage s = _storage();
        require(s.initized == false, "LibOwnable: initized");
        s.initized = true;
        transferOwnership(_newOwner);
    }

    /** ***** ***** ***** ***** *****
     * internal function
     ***** ***** ***** ***** ***** */
    function owner() internal view returns (address) {
        return _storage().owner;
    }

    function onlyOwner() internal view {
        require(owner() == msg.sender, "LibOwnable: caller is not the owner");
    }

    function transferOwnership(address _newOwner) internal {
        OwnableStorage storage s = _storage();
        address oldOwner = s.owner;
        s.owner = _newOwner;
        emit OwnershipTransferred(oldOwner, _newOwner);
    }
}
