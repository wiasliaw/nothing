// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC165Extension} from "../interface/IERC165.sol";
import {LibERC165} from "../library/LibERC165.sol";
import {LibOwnable} from "../library/LibOwnable.sol";

contract ERC165Fcaet is IERC165Extension {
    function supportsInterface(bytes4 _interfaceId)
        external
        view
        returns (bool)
    {
        return LibERC165.supportsInterface(_interfaceId);
    }

    function supportsBy(bytes4 _interfaceId) external view returns (address) {
        return LibERC165.supportsBy(_interfaceId);
    }

    function setInterfaceId(address _facet, bytes4 _interfaceId) external {
        LibOwnable.onlyOwner();
        LibERC165.setInterfaceId(_facet, _interfaceId);
    }

    function unsetInterfaceId(bytes4 _interfaceId) external {
        LibOwnable.onlyOwner();
        LibERC165.unsetInterfaceId(_interfaceId);
    }
}
