// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../lib/forge-std/src/Test.sol";
import {AOwnable, LibOwnable} from "../../src/abstract/AOwnable.sol";

contract TestAOwnable is Test, AOwnable {
    address private constant testAddress = address(1234);
    address private constant testOther = address(4321);

    function setUp() public {
        AOwnable.transferOwnership(testAddress);
    }

    function testOwner() public {
        assertEq(AOwnable.owner(), testAddress);
    }

    function testFailOnlyOwner() public onlyOwner view {}

    function testTransferOwnership() public {
        vm.expectEmit(true, true, true, true);
        emit LibOwnable.OwnershipTransferred(testAddress, testOther);
        AOwnable.transferOwnership(testOther);
        assertEq(AOwnable.owner(), testOther);
    }
}
