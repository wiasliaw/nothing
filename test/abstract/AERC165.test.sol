// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {AERC165} from "../../src/abstract/AERC165.sol";

contract TestAERC165 is Test, AERC165 {
    address private constant testAddress = address(1234);
    bytes4 private constant testInterfaceId =  hex"12345678";

    function setUp() public {
        AERC165._setInterfaceId(testAddress, testInterfaceId);
    }

    function testSupports() public {
        assertTrue(AERC165._supportsInterface(testInterfaceId));
        assertEq(AERC165._supportsBy(testInterfaceId), testAddress);
    }
}
