// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Proxy} from "openzeppelin-contracts/contracts/proxy/Proxy.sol";
import {ALookup, LibLookup} from "./abstract/ALookup.sol";

abstract contract Diamond is Proxy, ALookup {
    function _implementation() internal view override returns (address) {
        LibLookup.Facet memory facet = _lookup(msg.sig);
        require(facet.addr != address(0), "Diamond: Function does not exist");
        return facet.addr;
    }
}
