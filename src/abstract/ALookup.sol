// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibLookup {
    bytes32 private constant LOOKUP_STORAGE =
        keccak256("eip2535.lookup.storage");

    struct Facet {
        address addr;
    }

    struct LookupStorage {
        mapping(bytes4 => Facet) facets;
    }

    event SetFacet(address facet, bytes4[] selectors);

    function _storage() internal pure returns (LookupStorage storage s) {
        bytes32 position = LOOKUP_STORAGE;
        assembly {
            s.slot := position
        }
    }
}

abstract contract ALookup {
    function _lookup(bytes4 _sig)
        internal
        view
        returns (LibLookup.Facet memory facet)
    {
        return LibLookup._storage().facets[_sig];
    }

    function _setFacet(address _facet, bytes4[] memory _selectors) internal {
        LibLookup.LookupStorage storage ds = LibLookup._storage();

        for (uint256 i; i < _selectors.length; ) {
            ds.facets[_selectors[i]] = LibLookup.Facet(_facet);
            unchecked {
                ++i;
            }
        }
        emit LibLookup.SetFacet(_facet, _selectors);
    }
}
