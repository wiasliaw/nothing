// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibERC165} from "../library/LibERC165.sol";
import {LibOwnable} from "../library/LibOwnable.sol";

contract ERC165Fcaet {
    function supportsInterface(bytes4 _interfaceId)
        external
        view
        returns (bool)
    {
        return LibERC165._supportsInterface(_interfaceId);
    }

    function supportsBy(bytes4 _interfaceId) external view returns (address) {
        return LibERC165._supportsBy(_interfaceId);
    }

    function setInterfaceId(address _facet, bytes4 _interfaceId) external {
        LibOwnable._onlyOwner();
        LibERC165._setInterfaceId(_facet, _interfaceId);
    }

    function unsetInterfaceId(bytes4 _interfaceId) external {
        LibOwnable._onlyOwner();
        LibERC165._unsetInterfaceId(_interfaceId);
    }
}
