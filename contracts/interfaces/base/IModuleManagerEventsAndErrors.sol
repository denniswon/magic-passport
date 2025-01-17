// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

import { CallType } from "../../lib/ModeLib.sol";

/// @title ERC-7579 Module Manager Events and Errors Interface
/// @notice Provides event and error definitions for actions related to module management in smart accounts.
/// @dev Used by IModuleManager to define the events and errors associated with the installation and management of modules.
/// Special thanks to Biconomy, Rhinestone, and Solady team for foundational contributions
interface IModuleManagerEventsAndErrors {
    /// @notice Emitted when a module is installed onto a smart account.
    /// @param moduleTypeId The identifier for the type of module installed.
    /// @param module The address of the installed module.
    event ModuleInstalled(uint256 moduleTypeId, address module);

    /// @notice Emitted when a module is uninstalled from a smart account.
    /// @param moduleTypeId The identifier for the type of module uninstalled.
    /// @param module The address of the uninstalled module.
    event ModuleUninstalled(uint256 moduleTypeId, address module);

    /// @notice Thrown when attempting to remove the last validator.
    error CanNotRemoveLastValidator();

    /// @dev Thrown when the specified module address is not recognized as valid.
    error ValidatorNotInstalled(address module);

    /// @dev Thrown when there is no installed validator detected.
    error NoValidatorInstalled();

    /// @dev Thrown when the specified module address is not recognized as valid.
    error InvalidModule(address module);

    /// @dev Thrown when an invalid module type identifier is provided.
    error InvalidModuleTypeId(uint256 moduleTypeId);

    /// @dev Thrown when there is an attempt to install a module that is already installed.
    error ModuleAlreadyInstalled(uint256 moduleTypeId, address module);

    /// @dev Thrown when an operation is performed by an unauthorized operator.
    error UnauthorizedOperation(address operator);

    /// @dev Thrown when there is an attempt to uninstall a module that is not installed.
    error ModuleNotInstalled(uint256 moduleTypeId, address module);

    /// @dev Thrown when a module address is set to zero.
    error ModuleAddressCanNotBeZero();

    /// @dev Thrown when a post-check fails after hook execution.
    error HookPostCheckFailed();

    /// @dev Thrown when there is an attempt to install a hook while another is already installed.
    error HookAlreadyInstalled(address currentHook);

    /// @dev Thrown when there is an attempt to install a fallback handler for a selector already having one.
    error FallbackAlreadyInstalledForSelector(bytes4 selector);

    /// @dev Thrown when there is an attempt to uninstall a fallback handler for a selector that does not have one installed.
    error FallbackNotInstalledForSelector(bytes4 selector);

    /// @dev Thrown when a fallback handler fails to uninstall properly.
    error FallbackHandlerUninstallFailed();

    /// @dev Thrown when no fallback handler is available for a given selector.
    error MissingFallbackHandler(bytes4 selector);

    /// @dev Thrown when Invalid data is provided for MultiType install flow
    error InvalidInput();

    /// @dev Thrown when unable to validate Module Enable Mode signature
    error EnableModeSigError();

    /// Error thrown when account installs/uninstalls module with mismatched input `moduleTypeId`
    error MismatchModuleTypeId(uint256 moduleTypeId);

    /// @dev Thrown when there is an attempt to install a forbidden selector as a fallback handler.
    error FallbackSelectorForbidden();

    /// @dev Thrown when there is an attempt to install a fallback handler with an invalid calltype for a given selector.
    error FallbackCallTypeInvalid();

    /// @notice Error thrown when an execution with an unsupported CallType was made.
    /// @param callType The unsupported call type.
    error UnsupportedCallType(CallType callType);
}
