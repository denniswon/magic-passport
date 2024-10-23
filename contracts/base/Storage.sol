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

import { IStorage } from "../interfaces/base/IStorage.sol";

/// @title Passport - Storage
/// @notice Manages isolated storage spaces for Modular Smart Account in compliance with ERC-7201 standard to ensure collision-resistant storage.
/// @dev Implements the ERC-7201 namespaced storage pattern to maintain secure and isolated storage sections for different states within Passport suite.
/// @author @zeroknots | Rhinestone.wtf | zeroknots.eth
/// Special thanks to the Solady team for foundational contributions: https://github.com/Vectorized/solady
contract Storage is IStorage {
    /// @custom:storage-location erc7201:magic.storage.Passport
    /// ERC-7201 namespaced via `keccak256(abi.encode(uint256(keccak256(bytes("magic.storage.Passport"))) - 1)) & ~bytes32(uint256(0xff));`
    bytes32 private constant _STORAGE_LOCATION = 0x0bb70095b32b9671358306b0339b4c06e7cbd8cb82505941fba30d1eb5b82f00;

    /// @dev Utilizes ERC-7201's namespaced storage pattern for isolated storage access. This method computes
    /// the storage slot based on a predetermined location, ensuring collision-resistant storage for contract states.
    /// @custom:storage-location ERC-7201 formula applied to "magic.storage.Passport", facilitating unique
    /// namespace identification and storage segregation, as detailed in the specification.
    /// @return $ The proxy to the `AccountStorage` struct, providing a reference to the namespaced storage slot.
    function _getAccountStorage() internal pure returns (AccountStorage storage $) {
        assembly {
            $.slot := _STORAGE_LOCATION
        }
    }
}
