// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ISimple} from "../interface/ISimple.sol";
import {LibSimple} from "../library/LibSimple.sol";
import {LibOwnable} from "../../src/library/LibOwnable.sol";

contract SimpleFacet is ISimple {
    function set(uint256 _val) external returns (bool) {
        LibOwnable.onlyOwner();
        return LibSimple.set(_val);
    }

    function get() external view returns (uint256) {
        return LibSimple.get();
    }
}
