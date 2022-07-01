// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IOwnableFacet {
    function owner() external view returns (address);

    function transferOwnership(address _newOwner) external;
}
