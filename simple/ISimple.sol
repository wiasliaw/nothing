// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISimple {
    function set(uint256 value) external;

    function get() external view returns (uint256);
}
