// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

/// @title Stakeable Entity Interface
/// @notice Interface for staking, unlocking, and withdrawing Ether on an EntryPoint.
/// @dev Defines functions for managing stakes on an EntryPoint.
/// Special thanks to Biconomy, Rhinestone, and Solady team for foundational contributions
interface IStakeable {
    /// @notice Stakes a certain amount of Ether on an EntryPoint.
    /// @dev The contract should have enough Ether to cover the stake.
    /// @param epAddress The address of the EntryPoint where the stake is added.
    /// @param unstakeDelaySec The delay in seconds before the stake can be unlocked.
    function addStake(address epAddress, uint32 unstakeDelaySec) external payable;

    /// @notice Unlocks the stake on an EntryPoint.
    /// @dev This starts the unstaking delay after which funds can be withdrawn.
    /// @param epAddress The address of the EntryPoint from which the stake is to be unlocked.
    function unlockStake(address epAddress) external;

    /// @notice Withdraws the stake from an EntryPoint to a specified address.
    /// @dev This can only be done after the unstaking delay has passed since the unlock.
    /// @param epAddress The address of the EntryPoint where the stake is withdrawn from.
    /// @param withdrawAddress The address to receive the withdrawn stake.
    function withdrawStake(address epAddress, address payable withdrawAddress) external;
}
