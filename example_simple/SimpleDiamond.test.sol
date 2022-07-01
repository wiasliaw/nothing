// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {SimpleDiamond} from "./SimpleDiamond.sol";

// interface for testing
import {IOwnableFacet} from "../src/interface/IOwnableFacet.sol";
import {ISimple} from "./interface/ISimple.sol";

contract TestSimple is Test {
    address private _simple;
    address deployer = vm.addr(1);
    address other = vm.addr(2);

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function setUp() public {
        vm.prank(deployer);
        _simple = address(new SimpleDiamond());
    }

    function testOwnable() public {
        IOwnableFacet ownable = IOwnableFacet(_simple);
        vm.prank(deployer);

        // transferOwnership
        vm.expectEmit(true, true, false, false);
        emit OwnershipTransferred(deployer, other);
        ownable.transferOwnership(other);

        // owner
        assertEq(ownable.owner(), other);
    }

    function testSimple() public {
        ISimple simple = ISimple(_simple);
        vm.prank(deployer);
        assertTrue(simple.set(2535));
        assertEq(simple.get(), 2535);
    }
}
