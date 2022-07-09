// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibOwnable {
    struct OwnableStorage {
        address owner;
    }

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
}

abstract contract AOwnable {
    bytes32 private constant __OWNABLE_POSITION__ =
        keccak256("eip2535.ownable.storage");

    function __ownable_storage__()
        private
        pure
        returns (LibOwnable.OwnableStorage storage s)
    {
        bytes32 position = __OWNABLE_POSITION__;
        assembly {
            s.slot := position
        }
    }

    modifier onlyOwner() {
        require(_owner() == msg.sender, "LibOwnable: caller is not the owner");
        _;
    }

    function _init_ownable()
        internal
        view
        virtual
        returns (address, bytes4[] memory)
    {}

    function _owner() internal view virtual returns (address) {
        return __ownable_storage__().owner;
    }

    function _transferOwnership(address _newOwner) internal virtual {
        LibOwnable.OwnableStorage storage s = __ownable_storage__();
        address oldOwner = s.owner;
        s.owner = _newOwner;
        emit LibOwnable.OwnershipTransferred(oldOwner, _newOwner);
    }
}
