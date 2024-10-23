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
import { BootstrapLib } from "../lib/BootstrapLib.sol";
import { PassportBootstrap, BootstrapConfig } from "../utils/PassportBootstrap.sol";
import { Stakeable } from "../common/Stakeable.sol";
import { IERC7484 } from "../interfaces/IERC7484.sol";

/// @title K1ValidatorFactory for Passport Account
/// @notice Manages the creation of Modular Smart Accounts compliant with ERC-7579 and ERC-4337 using a K1 validator.
/// @author @zeroknots | Rhinestone.wtf | zeroknots.eth
/// Special thanks to the Solady team for foundational contributions: https://github.com/Vectorized/solady
contract K1ValidatorFactory is Stakeable {
    /// @notice Stores the implementation contract address used to create new Passport instances.
    /// @dev This address is set once upon deployment and cannot be changed afterwards.
    address public immutable ACCOUNT_IMPLEMENTATION;

    /// @notice Stores the K1 Validator module address.
    /// @dev This address is set once upon deployment and cannot be changed afterwards.
    address public immutable K1_VALIDATOR;

    /// @notice Stores the Bootstrapper module address.
    /// @dev This address is set once upon deployment and cannot be changed afterwards.
    PassportBootstrap public immutable BOOTSTRAPPER;

    IERC7484 public immutable REGISTRY;

    /// @notice Emitted when a new Smart Account is created, capturing the account details and associated module configurations.
    event AccountCreated(address indexed account, address indexed owner, uint256 indexed index);

    /// @notice Error thrown when a zero address is provided for the implementation, K1 validator, or bootstrapper.
    error ZeroAddressNotAllowed();

    /// @notice Error thrown when an inner call fails.
    error InnerCallFailed();

    /// @notice Constructor to set the immutable variables.
    /// @param implementation The address of the Passport implementation to be used for all deployments.
    /// @param factoryOwner The address of the factory owner.
    /// @param k1Validator The address of the K1 Validator module to be used for all deployments.
    /// @param bootstrapper The address of the Bootstrapper module to be used for all deployments.
    constructor(address implementation, address factoryOwner, address k1Validator, PassportBootstrap bootstrapper, IERC7484 registry) Stakeable(factoryOwner) {
        require(
            !(implementation == address(0) || k1Validator == address(0) || address(bootstrapper) == address(0) || factoryOwner == address(0)),
            ZeroAddressNotAllowed()
        );
        ACCOUNT_IMPLEMENTATION = implementation;
        K1_VALIDATOR = k1Validator;
        BOOTSTRAPPER = bootstrapper;
        REGISTRY = registry;
    }

    /// @notice Creates a new Passport with a specific validator and initialization data.
    /// @param eoaOwner The address of the EOA owner of the Passport.
    /// @param index The index of the Passport.
    /// @param attesters The list of attesters for the Passport.
    /// @param threshold The threshold for the Passport.
    /// @return The address of the newly created Passport.
    function createAccount(address eoaOwner, uint256 index, address[] calldata attesters, uint8 threshold) external payable returns (address payable) {
        // Compute the actual salt for deterministic deployment
        bytes32 actualSalt = keccak256(abi.encodePacked(eoaOwner, index, attesters, threshold));

        // Deploy the Passport contract using the computed salt
        (bool alreadyDeployed, address account) = LibClone.createDeterministicERC1967(msg.value, ACCOUNT_IMPLEMENTATION, actualSalt);

        // Create the validator configuration using the PassportBootstrap library
        BootstrapConfig memory validator = BootstrapLib.createSingleConfig(K1_VALIDATOR, abi.encodePacked(eoaOwner));
        bytes memory initData = BOOTSTRAPPER.getInitPassportWithSingleValidatorCalldata(validator, REGISTRY, attesters, threshold);

        // Initialize the account if it was not already deployed
        if (!alreadyDeployed) {
            IPassport(account).initializeAccount(initData);
            emit AccountCreated(account, eoaOwner, index);
        }
        return payable(account);
    }

    /// @notice Computes the expected address of a Passport contract using the factory's deterministic deployment algorithm.
    /// @param eoaOwner The address of the EOA owner of the Passport.
    /// @param index The index of the Passport.
    /// @param attesters The list of attesters for the Passport.
    /// @param threshold The threshold for the Passport.
    /// @return expectedAddress The expected address at which the Passport contract will be deployed if the provided parameters are used.
    function computeAccountAddress(
        address eoaOwner,
        uint256 index,
        address[] calldata attesters,
        uint8 threshold
    )
        external
        view
        returns (address payable expectedAddress)
    {
        // Compute the actual salt for deterministic deployment
        bytes32 actualSalt = keccak256(abi.encodePacked(eoaOwner, index, attesters, threshold));

        // Predict the deterministic address using the LibClone library
        expectedAddress = payable(LibClone.predictDeterministicAddressERC1967(ACCOUNT_IMPLEMENTATION, actualSalt, address(this)));
    }
}
