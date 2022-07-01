// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Address} from "openzeppelin-contracts/contracts/utils/Address.sol";

library LibERC165 {
    using Address for address;

    /// @dev storage position
    bytes32 private constant _STORAGE_POSITION =
        keccak256("facet.erc165.storage");

    /** ***** ***** ***** ***** *****
     * struct
     ***** ***** ***** ***** ***** */
    struct ERC165Storage {
        mapping(bytes4 => address) supported;
    }

    /** ***** ***** ***** ***** *****
     * private function
     ***** ***** ***** ***** ***** */
    function _storage() private pure returns (ERC165Storage storage s) {
        bytes32 position = _STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    /** ***** ***** ***** ***** *****
     * internal function
     ***** ***** ***** ***** ***** */
    function setInterfaceId(address _facet, bytes4 _interfaceId) internal {
        require(_facet.isContract(), "LibERC165: not a contract");
        _storage().supported[_interfaceId] = _facet;
    }

    function unsetInterfaceId(bytes4 _interfaceId) internal {
        delete _storage().supported[_interfaceId];
    }

    function supportsInterface(bytes4 _interfaceId)
        internal
        view
        returns (bool)
    {
        return _storage().supported[_interfaceId] != address(0);
    }

    function supportsBy(bytes4 _interfaceId) external view returns (address) {
        return _storage().supported[_interfaceId];
    }
}
