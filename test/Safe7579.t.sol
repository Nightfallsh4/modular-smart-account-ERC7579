// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { Test } from "forge-std/Test.sol";
import { console2 } from "forge-std/console2.sol";

import { LaunchpadBase } from "safe7579/test/Launchpad.t.sol";
import {ISafe7579} from "safe7579/src/ISafe7579.sol";

contract Safe7579Test is LaunchpadBase {
    
    function setUp()  public override {
        super.setUp();
    }

    function test_IsModuleInsatlled()  external {
        ISafe7579 safe7579 = ISafe7579(address(safe));
        bool isModule = safe7579.isModuleInstalled(1,address(defaultValidator),"");

        assert(isModule);
    }
}