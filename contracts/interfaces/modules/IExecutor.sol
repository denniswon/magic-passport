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

import { IModule } from "./IModule.sol";

/// @title Passport - IExecutor Interface
/// @notice Defines the interface for Executor modules within the Passport Smart Account framework, compliant with the ERC-7579 standard.
/// @dev Extends IModule to include functionalities specific to execution modules.
/// This interface is future-proof, allowing for expansion and integration of advanced features in subsequent versions.
/// @author @zeroknots | Rhinestone.wtf | zeroknots.eth
/// Special thanks to the Solady team for foundational contributions: https://github.com/Vectorized/solady
interface IExecutor is IModule {
// Future methods for execution management will be defined here to accommodate evolving requirements.
}
