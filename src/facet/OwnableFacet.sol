// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibOwnable} from "../library/LibOwnable.sol";

contract OwnableFacet {
    function owner() external view returns (address) {
        return LibOwnable._owner();
    }

    function transferOwnership(address _newOwner) external {
        LibOwnable._onlyOwner();
        LibOwnable._transferOwnership(_newOwner);
    }
}
