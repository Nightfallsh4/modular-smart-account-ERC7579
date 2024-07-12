// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { Test } from "forge-std/Test.sol";
import { console2 } from "forge-std/console2.sol";

import { LaunchpadBase } from "safe7579/test/Launchpad.t.sol";
import { ISafe7579 } from "safe7579/src/ISafe7579.sol";
import { Safe7579 } from "safe7579/src/Safe7579.sol";
import { Safe7579Launchpad } from "safe7579/src/Safe7579Launchpad.sol";

import { MockGuardianValidator } from "./mocks/MockGuardianValidator.sol";

import "safe7579/test/dependencies/EntryPoint.sol";

import { Safe } from "@safe-global/safe-contracts/contracts/Safe.sol";
import {
    SafeProxy,
    SafeProxyFactory
} from "@safe-global/safe-contracts/contracts/proxies/SafeProxyFactory.sol";

import { IEntryPoint } from "account-abstraction/interfaces/IEntryPoint.sol";
import { IERC7484 } from "safe7579/src/interfaces/IERC7484.sol";
import { MockRegistry } from "safe7579/test/mocks/MockRegistry.sol";
import { MockExecutor } from "safe7579/test/mocks/MockExecutor.sol";
import { MockTarget } from "safe7579/test//mocks/MockTarget.sol";


contract Safe7579Test is Test{

    address guardian1 = makeAddr("GUARDIAN_1");

    // Safe
    Safe singleton;
    SafeProxyFactory safeProxyFactory;
    Safe7579 safeTest;
    Safe7579Launchpad launchpad;

    // ERC4337
    IEntryPoint entrypoint;

    // ERC7579 Validators & Executors
    MockGuardianValidator defaultValidator;
    MockExecutor defaultExecutor;
    MockRegistry registry;

    // Target
    MockTarget target;

    function setUp() public {
        // super.setUp();
        // Setting Up

        // Set up EntryPoint
        entrypoint = etchEntrypoint();

        // Setup Safe contracts
        singleton = new Safe();
        safeProxyFactory = new SafeProxyFactory();

        // ERC7484 Registry for ERC7579
        registry = new MockRegistry();

        // ERC7579 Adapter for Safe
        safeTest = new Safe7579();
        launchpad = new Safe7579Launchpad(address(entrypoint), IERC7484(address(registry)));

        // Set up Modules

        // Setup Guardian Validator
        defaultValidator = new MockGuardianValidator();
        address[] memory guardians = new address[](1);
        guardians[0] = guardian1;
        
        bool[] memory isEnabled = new bool[](1);
        isEnabled[0] = true;
        defaultValidator.setGuardian(guardians, isEnabled);

        defaultExecutor = new MockExecutor();
        target = new MockTarget();
    }

    function test_IsGuardianValidatorSet()  external {
        bool isEnabled = defaultValidator.isGuardianEnabled(guardian1);
    }

    // function test_IsModuleInsatlled() external {
    //     ISafe7579 safe7579 = ISafe7579(address(safe));
    //     bool isModule = safe7579.isModuleInstalled(1, address(defaultValidator), "");

    //     assert(isModule);
    // }
}
