// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILookup {
    function lookup(bytes4 _sig) external view returns (address);

    function setFacet(address _facet, bytes4[] calldata _sigs) external;
}
