// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AERC165} from "../abstract/AERC165.sol";
import {IERC165Extension} from "../interface/IERC165.sol";

contract ERC165Facet is IERC165Extension, AERC165 {
    address private immutable __self__;

    constructor() {
        __self__ = address(this);
    }

    function init() external view returns (address, bytes4[] memory) {
        return _erc165_init();
    }

    function supportsInterface(bytes4 _interfaceId)
        external
        view
        returns (bool)
    {
        return _supportsInterface(_interfaceId);
    }

    function supportsBy(bytes4 _interfaceId) external view returns (address) {
        return _supportsBy(_interfaceId);
    }

    function _erc165_init()
        internal
        view
        override
        returns (address, bytes4[] memory)
    {
        bytes4[] memory selectors = new bytes4[](2);
        selectors[0] = IERC165Extension.supportsBy.selector;
        selectors[1] = IERC165Extension.supportsInterface.selector;
        return (__self__, selectors);
    }
}
