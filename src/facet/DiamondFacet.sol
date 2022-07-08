// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibLookup} from "../library/LibLookup.sol";
import {LibOwnable} from "../library/LibOwnable.sol";

contract DiamondFacet {
    function facetAddress(bytes4 _selector)
        internal
        view
        returns (address facetAddress_)
    {
        facetAddress_ = LibLookup._lookup(_selector).addr;
    }

    function setFacet(address _facet, bytes4[] memory _selectors) internal {
        LibOwnable._onlyOwner();
        LibLookup._setFacet(_facet, _selectors);

    }

    function resetFcaet(bytes4[] memory _selectors) internal {
        LibOwnable._onlyOwner();
        LibLookup._resetFacet(_selectors);
    }
}

