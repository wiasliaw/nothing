// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IOwnableFacet} from "../interface/IOwnableFacet.sol";
import {LibOwnable} from "../library/LibOwnable.sol";

contract OwnableFacet is IOwnableFacet {
    function init(address _newOwner) external {
        LibOwnable.init(_newOwner);
    }

    function owner() external view returns (address) {
        return LibOwnable.owner();
    }

    function transferOwnership(address _newOwner) external {
        LibOwnable.onlyOwner();
        LibOwnable.transferOwnership(_newOwner);
    }
}
