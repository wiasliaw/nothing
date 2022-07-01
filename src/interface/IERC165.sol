// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

interface IERC165Extension is IERC165 {
    function supportsBy(bytes4 interfaceId) external view returns (address);
}
