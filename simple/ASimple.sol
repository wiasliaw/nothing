// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract ASimple {
    bytes32 private constant __SIMPLE_POSITION__ =
        keccak256("eip2535.simple.storage");

    struct SimpleStorage {
        uint256 value;
    }

    function __simple_storage__()
        private
        pure
        returns (SimpleStorage storage s)
    {
        bytes32 position = __SIMPLE_POSITION__;
        assembly {
            s.slot := position
        }
    }

    function _set(uint256 _value) internal {
        __simple_storage__().value = _value;
    }

    function _get() internal view returns (uint256) {
        return __simple_storage__().value;
    }
}
