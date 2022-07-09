// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {SimpleDiamond} from "./SimpleDiamond.sol";

import {OwnableFacet} from "../src/facet/OwnableFacet.sol";
import {LookupFacet} from "../src/facet/LookupFacet.sol";
import {SimpleFacet} from "./SimpleFacet.sol";

import {IOwnable} from "../src/interface/IOwnable.sol";
import {ILookup} from "../src/interface/ILookup.sol";
import {Initializer} from "../src/interface/Initializer.sol";
import {ISimple} from "./ISimple.sol";

contract TestSimpleDiamond is Test {
    address deployer = address(uint160(1234));
    address other = address(uint160(4321));

    address simple;
    address facet;

    function setUp() public {
        address ownableFacet = address(new OwnableFacet());
        address lookupFacet = address(new LookupFacet());
        facet = address(new SimpleFacet());

        vm.prank(deployer);
        simple = address(new SimpleDiamond(ownableFacet, lookupFacet));
    }

    function testOwner() public {
        assertEq(IOwnable(simple).owner(), deployer);
    }

    function testTransferOwnership() public {
        vm.prank(deployer);
        IOwnable(simple).transferOwnership(other);
        assertEq(IOwnable(simple).owner(), other);
    }

    function testRegisterSimpleFacet() public {
        // regist
        (address _f, bytes4[] memory _s) = Initializer(facet).init();
        vm.prank(deployer);
        ILookup(simple).setFacet(_f, _s);

        // call simple
        assertEq(ISimple(simple).get(), 0);
        ISimple(simple).set(56);
        assertEq(ISimple(simple).get(), 56);
    }
}
