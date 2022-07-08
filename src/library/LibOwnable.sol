// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibOwnable {
    bytes32 private constant STORAGE_POSITION =
        keccak256("diamond.ownable.storage");

    struct OwnableStorage {
        address owner;
    }

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    function _storage() private pure returns (OwnableStorage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    function _owner() internal view returns (address) {
        return _storage().owner;
    }

    function _onlyOwner() internal view {
        require(_owner() == msg.sender, "LibOwnable: caller is not the owner");
    }

    function _transferOwnership(address _newOwner) internal {
        OwnableStorage storage s = _storage();
        address oldOwner = s.owner;
        s.owner = _newOwner;
        emit OwnershipTransferred(oldOwner, _newOwner);
    }
}
