// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// ──────────────────────────────────────────────────────────────────────────────
//     _   __    _  __
//    / | / /__ | |/ /_  _______
//   /  |/ / _ \|   / / / / ___/
//  / /|  /  __/   / /_/ (__  )
// /_/ |_/\___/_/|_\__,_/____/
//
// ──────────────────────────────────────────────────────────────────────────────
// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

/// @title Passport - ERC-7579 Module Base Interface
/// @notice Interface for module management in smart accounts, complying with ERC-7579 specifications.
/// @dev Defines the lifecycle hooks and checks for modules within the smart account architecture.
/// This interface includes methods for installing, uninstalling, and verifying module types and initialization status.
/// @author @zeroknots | Rhinestone.wtf | zeroknots.eth
/// Special thanks to the Solady team for foundational contributions: https://github.com/Vectorized/solady
interface IModule {
    /// @notice Installs the module with necessary initialization data.
    /// @dev Reverts if the module is already initialized.
    /// @param data Arbitrary data required for initializing the module during `onInstall`.
    function onInstall(bytes calldata data) external;

    /// @notice Uninstalls the module and allows for cleanup via arbitrary data.
    /// @dev Reverts if any issues occur that prevent clean uninstallation.
    /// @param data Arbitrary data required for deinitializing the module during `onUninstall`.
    function onUninstall(bytes calldata data) external;

    /// @notice Determines if the module matches a specific module type.
    /// @dev Should return true if the module corresponds to the type ID, false otherwise.
    /// @param moduleTypeId Numeric ID of the module type as per ERC-7579 specifications.
    /// @return True if the module is of the specified type, false otherwise.
    function isModuleType(uint256 moduleTypeId) external view returns (bool);

    /// @notice Checks if the module has been initialized for a specific smart account.
    /// @dev Returns true if initialized, false otherwise.
    /// @param smartAccount Address of the smart account to check for initialization status.
    /// @return True if the module is initialized for the given smart account, false otherwise.
    function isInitialized(address smartAccount) external view returns (bool);
}
