// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

/// @title Execution Manager Events and Errors Interface
/// @notice Interface for defining events and errors related to transaction execution processes within smart accounts.
/// @dev This interface defines events and errors used by execution manager to handle and report the operational status of smart account transactions.
/// It is a part of the Passport suite of contracts aimed at implementing flexible and secure smart account operations.
/// Special thanks to Biconomy, Rhinestone, and Solady team for foundational contributions
interface IBaseAccountEventsAndErrors {
    /// @dev Throws an error when a caller is not authorized to access an account.
    error AccountAccessUnauthorized();
}
