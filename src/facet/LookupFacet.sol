// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ALookup} from "../abstract/ALookup.sol";
import {AOwnable} from "../abstract/AOwnable.sol";
import {ILookup} from "../interface/ILookup.sol";

contract LookupFacet is ILookup, ALookup, AOwnable {
    address private immutable __self__;

    constructor() {
        __self__ = address(this);
    }

    function init() external view returns (address, bytes4[] memory) {
        return _init_lookup();
    }

    function lookup(bytes4 _sig) external view returns (address) {
        return _lookup(_sig).addr;
    }

    function setFacet(address _facet, bytes4[] calldata _sigs)
        external
        onlyOwner
    {
        _setFacet(_facet, _sigs);
    }

    function _init_lookup()
        internal
        view
        override
        returns (address, bytes4[] memory)
    {
        bytes4[] memory selectors = new bytes4[](2);
        selectors[0] = ILookup.lookup.selector;
        selectors[1] = ILookup.setFacet.selector;
        return (__self__, selectors);
    }
}
