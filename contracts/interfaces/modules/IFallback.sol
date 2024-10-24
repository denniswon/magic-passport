// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

import { IModule } from "./IModule.sol";

/// @title Passport - IFallback Interface
/// @notice Defines the interface for Fallback modules within the Passport Smart Account framework, compliant with the ERC-7579 standard.
/// @dev Extends IModule to include functionalities specific to fallback modules.
/// This interface is future-proof, allowing for expansion and integration of advanced features in subsequent versions.
/// Special thanks to Biconomy, Rhinestone, and Solady team for foundational contributions
interface IFallback is IModule {
// Future methods for fallback management will be defined here to accommodate evolving blockchain technologies.
}
