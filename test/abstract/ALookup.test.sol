// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {ALookup, LibLookup} from "../../src/abstract/ALookup.sol";

contract TestALookupTable is Test, ALookup {
    function testLookupTable() public {
        address testAddress = address(1234);
        bytes4[] memory testSelectors = new bytes4[](2);
        testSelectors[0] = hex"11111111";
        testSelectors[1] = hex"22222222";

        vm.expectEmit(true, true, true, true);
        emit LibLookup.SetFacet(testAddress, testSelectors);
        _setFacet(testAddress, testSelectors);

        assertEq(_lookup(hex"11111111").addr, testAddress);
        assertEq(_lookup(hex"22222222").addr, testAddress);
        assertEq(_lookup(hex"33333333").addr, address(0));
    }
}
