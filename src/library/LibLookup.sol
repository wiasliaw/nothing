// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibLookup {
    bytes32 private constant STORAGE_POSITION =
        keccak256("diamond.lookup.storage");

    struct Facet {
        address addr;
    }

    struct LookupStorage {
        mapping(bytes4 => Facet) facets;
    }

    event SetFacet(address facet, bytes4[] selectors);

    function _storage() private pure returns (LookupStorage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    function _lookup(bytes4 _sig)
        internal
        view
        returns (LibLookup.Facet memory facet)
    {
        return _storage().facets[_sig];
    }

    function _setFacet(address _facet, bytes4[] memory _selectors) internal {
        LibLookup.LookupStorage storage ds = _storage();
        for (uint256 i; i < _selectors.length; ) {
            ds.facets[_selectors[i]] = LibLookup.Facet(_facet);
            unchecked {
                ++i;
            }
        }
        emit LibLookup.SetFacet(_facet, _selectors);
    }

    function _resetFacet(bytes4[] memory _selectors) internal {
        LibLookup.LookupStorage storage ds = _storage();
        for (uint256 i; i < _selectors.length; ) {
            delete ds.facets[_selectors[i]];
            unchecked {
                ++i;
            }
        }
        emit LibLookup.SetFacet(address(0), _selectors);
    }
}
