// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AOwnable} from "../abstract/AOwnable.sol";
import {IOwnable} from "../interface/IOwnable.sol";

contract OwnableFacet is IOwnable, AOwnable {
    address private immutable __self__;

    constructor() {
        __self__ = address(this);
    }

    function init() external view returns (address, bytes4[] memory) {
        return _init_ownable();
    }

    function owner() external view returns (address) {
        return _owner();
    }

    function transferOwnership(address newOwner) external onlyOwner {
        _transferOwnership(newOwner);
    }

    function _init_ownable()
        internal
        view
        override
        returns (address, bytes4[] memory)
    {
        bytes4[] memory selectors = new bytes4[](2);
        selectors[0] = IOwnable.owner.selector;
        selectors[1] = IOwnable.transferOwnership.selector;
        return (__self__, selectors);
    }
}
