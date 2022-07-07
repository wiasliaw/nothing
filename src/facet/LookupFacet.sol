// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ALookup} from "../abstract/ALookup.sol";
import {AOwnable} from "../abstract/AOwnable.sol";

interface ILookupFacet {
    function lookup(bytes4 _sig) external view returns (address);

    function setFacet(address _facet, bytes4[] calldata _sigs) external;
}

contract LookupFacet is ILookupFacet, ALookup, AOwnable {
    function lookup(bytes4 _sig) external view returns (address) {
        return _lookup(_sig).addr;
    }

    function setFacet(address _facet, bytes4[] calldata _sigs)
        external
        onlyOwner
    {
        _setFacet(_facet, _sigs);
    }
}
