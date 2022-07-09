// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract AERC165 {
    bytes32 private constant __ERC165_POSITION__ =
        keccak256("eip2535.erc165.storage");

    struct ERC165Storage {
        mapping(bytes4 => address) supported;
    }

    function __erc165_storage__()
        private
        pure
        returns (ERC165Storage storage s)
    {
        bytes32 position = __ERC165_POSITION__;
        assembly {
            s.slot := position
        }
    }

    function _erc165_init()
        internal
        view
        virtual
        returns (address, bytes4[] memory)
    {}

    function _supportsInterface(bytes4 _interfaceId)
        internal
        view
        virtual
        returns (bool)
    {
        return __erc165_storage__().supported[_interfaceId] != address(0);
    }

    function _supportsBy(bytes4 _interfaceId)
        internal
        view
        virtual
        returns (address)
    {
        return __erc165_storage__().supported[_interfaceId];
    }

    function _setInterfaceId(address _facet, bytes4 _interfaceId)
        internal
        virtual
    {
        __erc165_storage__().supported[_interfaceId] = _facet;
    }
}
