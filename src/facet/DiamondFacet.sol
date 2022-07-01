// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../library/LibDiamond.sol";
import {LibOwnable} from "../library/LibOwnable.sol";

contract DiamondFacet {
    function facetAddress(bytes4 _selector)
        internal
        view
        returns (address facetAddress_)
    {
        facetAddress_ = LibDiamond.facetAddress(_selector);
    }

    function setFacet(address _facet, bytes4[] memory _selectors) internal {
        LibOwnable.onlyOwner();
        LibDiamond.setFacet(_facet, _selectors);

    }

    function resetFcaet(bytes4[] memory _selectors) internal {
        LibOwnable.onlyOwner();
        LibDiamond.resetFcaet(_selectors);
    }
}

