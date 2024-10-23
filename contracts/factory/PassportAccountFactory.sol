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
import { LibClone } from "solady/utils/LibClone.sol";
import { IPassport } from "../interfaces/IPassport.sol";
import { Stakeable } from "../common/Stakeable.sol";
import { IPassportFactory } from "../interfaces/factory/IPassportFactory.sol";

/// @title Passport Account Factory
/// @notice Manages the creation of Modular Smart Accounts compliant with ERC-7579 and ERC-4337 using a factory pattern.
/// @author @zeroknots | Rhinestone.wtf | zeroknots.eth
/// Special thanks to the Solady team for foundational contributions: https://github.com/Vectorized/solady
contract PassportAccountFactory is Stakeable, IPassportFactory {
    /// @notice Address of the implementation contract used to create new Passport instances.
    /// @dev This address is immutable and set upon deployment, ensuring the implementation cannot be changed.
    address public immutable ACCOUNT_IMPLEMENTATION;

    /// @notice Constructor to set the smart account implementation address and the factory owner.
    /// @param implementation_ The address of the Passport implementation to be used for all deployments.
    /// @param owner_ The address of the owner of the factory.
    constructor(address implementation_, address owner_) Stakeable(owner_) {
        require(implementation_ != address(0), ImplementationAddressCanNotBeZero());
        require(owner_ != address(0), ZeroAddressNotAllowed());
        ACCOUNT_IMPLEMENTATION = implementation_;
    }

    /// @notice Creates a new Passport account with the provided initialization data.
    /// @param initData Initialization data to be called on the new Smart Account.
    /// @param salt Unique salt for the Smart Account creation.
    /// @return The address of the newly created Passport account.
    function createAccount(bytes calldata initData, bytes32 salt) external payable override returns (address payable) {
        // Compute the actual salt for deterministic deployment
        bytes32 actualSalt = keccak256(abi.encodePacked(initData, salt));

        // Deploy the account using the deterministic address
        (bool alreadyDeployed, address account) = LibClone.createDeterministicERC1967(msg.value, ACCOUNT_IMPLEMENTATION, actualSalt);

        if (!alreadyDeployed) {
            IPassport(account).initializeAccount(initData);
            emit AccountCreated(account, initData, salt);
        }
        return payable(account);
    }

    /// @notice Computes the expected address of a Passport contract using the factory's deterministic deployment algorithm.
    /// @param initData - Initialization data to be called on the new Smart Account.
    /// @param salt - Unique salt for the Smart Account creation.
    /// @return expectedAddress The expected address at which the Passport contract will be deployed if the provided parameters are used.
    function computeAccountAddress(bytes calldata initData, bytes32 salt) external view override returns (address payable expectedAddress) {
        // Compute the actual salt for deterministic deployment
        bytes32 actualSalt = keccak256(abi.encodePacked(initData, salt));
        expectedAddress = payable(LibClone.predictDeterministicAddressERC1967(ACCOUNT_IMPLEMENTATION, actualSalt, address(this)));
    }
}
