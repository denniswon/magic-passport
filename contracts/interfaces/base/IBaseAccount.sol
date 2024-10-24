// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

import { IBaseAccountEventsAndErrors } from "./IBaseAccountEventsAndErrors.sol";

/// @title Passport - IBaseAccount
/// @notice Interface for the BaseAccount functionalities compliant with ERC-7579 and ERC-4337.
/// @dev Interface for organizing the base functionalities using the Passport suite.
/// Special thanks to Biconomy, Rhinestone, and Solady team for foundational contributions
interface IBaseAccount is IBaseAccountEventsAndErrors {
    /// @notice Adds deposit to the EntryPoint to fund transactions.
    function addDeposit() external payable;

    /// @notice Withdraws ETH from the EntryPoint to a specified address.
    /// @param to The address to receive the withdrawn funds.
    /// @param amount The amount to withdraw.
    function withdrawDepositTo(address to, uint256 amount) external payable;

    /// @notice Gets the nonce for a particular key.
    /// @param key The nonce key.
    /// @return The nonce associated with the key.
    function nonce(uint192 key) external view returns (uint256);

    /// @notice Returns the current deposit balance of this account on the EntryPoint.
    /// @return The current balance held at the EntryPoint.
    function getDeposit() external view returns (uint256);

    /// @notice Retrieves the address of the EntryPoint contract, currently using version 0.7.
    /// @return The address of the EntryPoint contract.
    function entryPoint() external view returns (address);
}
