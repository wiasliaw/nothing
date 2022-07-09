// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ISimple} from "./ISimple.sol";
import {ASimple} from "./ASimple.sol";

contract SimpleFacet is ISimple, ASimple {
    address private immutable __self__;

    constructor() {
        __self__ = address(this);
    }

    function init() external view returns (address, bytes4[] memory) {
        return _simple_init();
    }

    function set(uint256 _value) external {
        _set(_value);
    }

    function get() external view returns (uint256) {
        return _get();
    }

    function _simple_init() internal view returns (address, bytes4[] memory) {
        bytes4[] memory selectors = new bytes4[](2);
        selectors[0] = ISimple.set.selector;
        selectors[1] = ISimple.get.selector;
        return (__self__, selectors);
    }
}
