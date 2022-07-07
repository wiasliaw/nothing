// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibERC165 {
    bytes32 private constant _STORAGE_POSITION =
        keccak256("facet.erc165.storage");

    struct ERC165Storage {
        mapping(bytes4 => address) supported;
    }

    function _storage() internal pure returns (ERC165Storage storage s) {
        bytes32 position = _STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }
}

abstract contract AERC165 {
    function _supportsInterface(bytes4 _interfaceId)
        internal
        view
        returns (bool)
    {
        return LibERC165._storage().supported[_interfaceId] != address(0);
    }

    function _supportsBy(bytes4 _interfaceId) internal view returns (address) {
        return LibERC165._storage().supported[_interfaceId];
    }

    function _setInterfaceId(address _facet, bytes4 _interfaceId) internal {
        LibERC165._storage().supported[_interfaceId] = _facet;
    }
}
