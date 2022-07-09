// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {AOwnable, LibOwnable} from "../../src/abstract/AOwnable.sol";

contract TestAOwnable is Test, AOwnable {
    address private constant testAddress = address(1234);
    address private constant testOther = address(4321);

    function setUp() public {
        AOwnable._transferOwnership(testAddress);
    }

    function testOwner() public {
        assertEq(AOwnable._owner(), testAddress);
    }

    function testFailOnlyOwner() public view onlyOwner {}

    function testTransferOwnership() public {
        vm.expectEmit(true, true, true, true);
        emit LibOwnable.OwnershipTransferred(testAddress, testOther);
        AOwnable._transferOwnership(testOther);
        assertEq(AOwnable._owner(), testOther);
    }
}
