// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

import { Ownable } from "solady/auth/Ownable.sol";
import { IEntryPoint } from "account-abstraction/interfaces/IEntryPoint.sol";

import { IStakeable } from "../interfaces/common/IStakeable.sol";

/// @title Stakeable Entity
/// @notice Provides functionality to stake, unlock, and withdraw Ether on an EntryPoint.
/// Special thanks to Biconomy, Rhinestone, and Solady team for foundational contributions
contract Stakeable is Ownable, IStakeable {
    /// @notice Error thrown when an invalid EntryPoint address is provided.
    error InvalidEntryPointAddress();

    constructor(address newOwner) {
        _setOwner(newOwner);
    }

    /// @notice Stakes a certain amount of Ether on an EntryPoint.
    /// @dev The contract should have enough Ether to cover the stake.
    /// @param epAddress The address of the EntryPoint where the stake is added.
    /// @param unstakeDelaySec The delay in seconds before the stake can be unlocked.
    function addStake(address epAddress, uint32 unstakeDelaySec) external payable onlyOwner {
        require(epAddress != address(0), InvalidEntryPointAddress());
        IEntryPoint(epAddress).addStake{ value: msg.value }(unstakeDelaySec);
    }

    /// @notice Unlocks the stake on an EntryPoint.
    /// @dev This starts the unstaking delay after which funds can be withdrawn.
    /// @param epAddress The address of the EntryPoint from which the stake is to be unlocked.
    function unlockStake(address epAddress) external onlyOwner {
        require(epAddress != address(0), InvalidEntryPointAddress());
        IEntryPoint(epAddress).unlockStake();
    }

    /// @notice Withdraws the stake from an EntryPoint to a specified address.
    /// @dev This can only be done after the unstaking delay has passed since the unlock.
    /// @param epAddress The address of the EntryPoint where the stake is withdrawn from.
    /// @param withdrawAddress The address to receive the withdrawn stake.
    function withdrawStake(address epAddress, address payable withdrawAddress) external onlyOwner {
        require(epAddress != address(0), InvalidEntryPointAddress());
        IEntryPoint(epAddress).withdrawStake(withdrawAddress);
    }
}
