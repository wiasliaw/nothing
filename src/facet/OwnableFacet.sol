// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AOwnable} from "../abstract/AOwnable.sol";

interface IOwnableFacet {
    function owner() external view returns (address);

    function transferOwnership(address newOwner) external;
}

contract OwnableFacet is IOwnableFacet, AOwnable {
    function owner() external view returns (address) {
        return _owner();
    }

    function transferOwnership(address newOwner) external onlyOwner {
        _transferOwnership(newOwner);
    }
}
