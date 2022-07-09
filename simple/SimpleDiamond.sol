// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Diamond} from "../src/Diamond.sol";
import {ALookup} from "../src/abstract/ALookup.sol";
import {AOwnable} from "../src/abstract/AOwnable.sol";
import {Initializer} from "../src/interface/Initializer.sol";

contract SimpleDiamond is ALookup, AOwnable, Diamond {
    constructor(address _ownableFacet, address _lookupFacet) {
        address facet;
        bytes4[] memory selectors;

        AOwnable._transferOwnership(msg.sender);

        (facet, selectors) = Initializer(_ownableFacet).init();
        ALookup._setFacet(facet, selectors);
        (facet, selectors) = Initializer(_lookupFacet).init();
        ALookup._setFacet(facet, selectors);
    }
}
