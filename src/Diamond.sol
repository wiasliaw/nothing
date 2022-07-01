// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Proxy} from "openzeppelin-contracts/contracts/proxy/Proxy.sol";
import {LibDiamond} from "./library/LibDiamond.sol";

abstract contract Diamond is Proxy {
    function _implementation() internal view override returns (address addr) {
        addr = LibDiamond.facetAddress(msg.sig);
        require(addr != address(0), "Diamond: Function does not exist");
    }
}
