// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibLookup {
    struct Facet {
        address addr;
    }

    struct LookupStorage {
        mapping(bytes4 => Facet) facets;
    }

    event SetFacet(address facet, bytes4[] selectors);
}

abstract contract ALookup {
    bytes32 private constant __LOOKUP_POSITION__ =
        keccak256("eip2535.lookup.storage");

    function __lookup_storage__()
        private
        pure
        returns (LibLookup.LookupStorage storage s)
    {
        bytes32 position = __LOOKUP_POSITION__;
        assembly {
            s.slot := position
        }
    }

    function _init_lookup()
        internal
        view
        virtual
        returns (address, bytes4[] memory)
    {}

    function _lookup(bytes4 _sig)
        internal
        view
        virtual
        returns (LibLookup.Facet memory facet)
    {
        return __lookup_storage__().facets[_sig];
    }

    function _setFacet(address _facet, bytes4[] memory _selectors)
        internal
        virtual
    {
        LibLookup.LookupStorage storage ds = __lookup_storage__();

        for (uint256 i; i < _selectors.length; ) {
            ds.facets[_selectors[i]] = LibLookup.Facet(_facet);
            unchecked {
                ++i;
            }
        }
        emit LibLookup.SetFacet(_facet, _selectors);
    }
}
