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

/// @title Execution
/// @notice Struct to encapsulate execution data for a transaction
struct Execution {
    /// @notice The target address for the transaction
    address target;
    /// @notice The value in wei to send with the transaction
    uint256 value;
    /// @notice The calldata for the transaction
    bytes callData;
}
