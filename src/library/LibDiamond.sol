// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Address} from "openzeppelin-contracts/contracts/utils/Address.sol";

library LibDiamond {
    using Address for address;

    /// @dev storage position
    bytes32 private constant _STORAGE_POSITION =
        keccak256("facet.diamond.storage");

    /** ***** ***** ***** ***** *****
     * struct
     ***** ***** ***** ***** ***** */
    struct Facet {
        // @todo: add meta info, bytes12 remain
        address addr;
    }

    struct DiamondStorage {
        mapping(bytes4 => Facet) facets;
    }

    /** ***** ***** ***** ***** *****
     * private function
     ***** ***** ***** ***** ***** */
    function _storage() private pure returns (DiamondStorage storage s) {
        bytes32 position = _STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    /** ***** ***** ***** ***** *****
     * internal function
     ***** ***** ***** ***** ***** */
    function facetAddress(bytes4 _selector)
        internal
        view
        returns (address facetAddress_)
    {
        facetAddress_ = _storage().facets[_selector].addr;
    }

    function setFacet(address _facet, bytes4[] memory _selectors) internal {
        require(_facet.isContract(), "LibDiamond: not a contract");
        DiamondStorage storage s = _storage();
        for (uint256 i; i < _selectors.length; ++i) {
            s.facets[_selectors[i]] = Facet(_facet);
        }
    }

    function resetFcaet(bytes4[] memory _selectors) internal {
        DiamondStorage storage s = _storage();
        for (uint256 i; i < _selectors.length; ++i) {
            delete s.facets[_selectors[i]];
        }
    }
}
