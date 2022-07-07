// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibOwnable {
    bytes32 private constant STORAGE_POSITION =
        keccak256("facet.ownable.storage");

    struct OwnableStorage {
        address owner;
    }

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    function _storage() internal pure returns (OwnableStorage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }
}

abstract contract AOwnable {
    modifier onlyOwner() {
        require(_owner() == msg.sender, "LibOwnable: caller is not the owner");
        _;
    }

    function _owner() internal view returns (address) {
        return LibOwnable._storage().owner;
    }

    function _transferOwnership(address _newOwner) internal {
        LibOwnable.OwnableStorage storage s = LibOwnable._storage();
        address oldOwner = s.owner;
        s.owner = _newOwner;
        emit LibOwnable.OwnershipTransferred(oldOwner, _newOwner);
    }
}
