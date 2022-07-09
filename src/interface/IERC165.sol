// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC165Extension {
    function supportsInterface(bytes4 _interfaceId)
        external
        view
        returns (bool);

    function supportsBy(bytes4 _interfaceId) external view returns (address);
}
