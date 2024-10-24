// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

import { IAccountConfig } from "./base/IAccountConfig.sol";
import { IExecutionHelper } from "./base/IExecutionHelper.sol";
import { IModuleManager } from "./base/IModuleManager.sol";

/// @title Passport - IERC7579Account
/// @notice This interface integrates the functionalities required for a modular smart account compliant with ERC-7579 and ERC-4337 standards.
/// @dev Combines configurations and operational management for smart accounts, bridging IAccountConfig, IExecutionHelper, and IModuleManager.
/// Interfaces designed to support the comprehensive management of smart account operations including execution management and modular configurations.
/// Special thanks to Biconomy, Rhinestone, and Solady team for foundational contributions
interface IERC7579Account is IAccountConfig, IExecutionHelper, IModuleManager {
    /// @dev Validates a smart account signature according to ERC-1271 standards.
    /// This method may delegate the call to a validator module to check the signature.
    /// @param hash The hash of the data being validated.
    /// @param data The signed data to validate.
    function isValidSignature(bytes32 hash, bytes calldata data) external view returns (bytes4);
}
