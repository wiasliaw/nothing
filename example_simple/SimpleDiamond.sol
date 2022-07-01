// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// diamond
import {Diamond} from "../src/Diamond.sol";

// facet
import {OwnableFacet} from "../src/facet/OwnableFacet.sol";
import {SimpleFacet} from "./facet/SimpleFacet.sol";

// lib
import {LibDiamond} from "../src/library/LibDiamond.sol";
import {LibOwnable} from "../src/library/LibOwnable.sol";

// interface
import {IOwnableFacet} from "../src/interface/IOwnableFacet.sol";
import {ISimple} from "./interface/ISimple.sol";

contract SimpleDiamond is Diamond {
    constructor() {
        OwnableFacet ownable = new OwnableFacet();
        SimpleFacet simple = new SimpleFacet();

        // init ownable
        LibOwnable.init(msg.sender);

        // register ownable
        bytes4[] memory selectors = new bytes4[](2);
        selectors[0] = IOwnableFacet.owner.selector;
        selectors[1] = IOwnableFacet.transferOwnership.selector;
        LibDiamond.setFacet(address(ownable), selectors);

        // register simple
        selectors[0] = ISimple.get.selector;
        selectors[1] = ISimple.set.selector;
        LibDiamond.setFacet(address(simple), selectors);
    }
}
