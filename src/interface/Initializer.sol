// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Initializer {
    function init() external view returns (address, bytes4[] memory);
}
