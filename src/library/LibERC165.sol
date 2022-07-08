// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibERC165 {
    bytes32 private constant STORAGE_POSITION =
        keccak256("diamond.erc165.storage");

    struct ERC165Storage {
        mapping(bytes4 => address) supported;
    }

    function _storage() private pure returns (ERC165Storage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    function _setInterfaceId(address _facet, bytes4 _interfaceId) internal {
        _storage().supported[_interfaceId] = _facet;
    }

    function _unsetInterfaceId(bytes4 _interfaceId) internal {
        delete _storage().supported[_interfaceId];
    }

    function _supportsInterface(bytes4 _interfaceId)
        internal
        view
        returns (bool)
    {
        return _storage().supported[_interfaceId] != address(0);
    }

    function _supportsBy(bytes4 _interfaceId) internal view returns (address) {
        return _storage().supported[_interfaceId];
    }
}
