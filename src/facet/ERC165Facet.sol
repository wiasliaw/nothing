// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AERC165} from "../abstract/AERC165.sol";

interface IERC165Extension {
    function supportsInterface(bytes4 _interfaceId)
        external
        view
        returns (bool);

    function supportsBy(bytes4 _interfaceId) external view returns (address);
}

contract ERC165Facet is IERC165Extension, AERC165 {
    function supportsInterface(bytes4 _interfaceId)
        external
        view
        returns (bool)
    {
        return _supportsInterface(_interfaceId);
    }

    function supportsBy(bytes4 _interfaceId) external view returns (address) {
        return _supportsBy(_interfaceId);
    }
}
