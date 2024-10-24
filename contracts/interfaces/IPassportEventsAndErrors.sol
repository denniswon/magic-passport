// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

import { PackedUserOperation } from "account-abstraction/interfaces/PackedUserOperation.sol";

/// @title Passport - IPassport Events and Errors
/// @notice Defines common errors for the Passport smart account management interface.
/// Special thanks to Biconomy, Rhinestone, and Solady team for foundational contributions
interface IPassportEventsAndErrors {
    /// @notice Emitted when a user operation is executed from `executeUserOp`
    /// @param userOp The user operation that was executed.
    /// @param innerCallRet The return data from the inner call execution.
    event Executed(PackedUserOperation userOp, bytes innerCallRet);

    /// @notice Error thrown when an unsupported ModuleType is requested.
    /// @param moduleTypeId The ID of the unsupported module type.
    error UnsupportedModuleType(uint256 moduleTypeId);

    /// @notice Error thrown on failed execution.
    error ExecutionFailed();

    /// @notice Error thrown when the Factory fails to initialize the account with posted bootstrap data.
    error PassportInitializationFailed();

    /// @notice Error thrown when a zero address is provided as the Entry Point address.
    error EntryPointCanNotBeZero();

    /// @notice Error thrown when the provided implementation address is invalid.
    error InvalidImplementationAddress();

    /// @notice Error thrown when the provided implementation address is not a contract.
    error ImplementationIsNotAContract();

    /// @notice Error thrown when an inner call fails.
    error InnerCallFailed();

    /// @notice Error thrown when attempted to emergency-uninstall a hook
    error EmergencyTimeLockNotExpired();
}
