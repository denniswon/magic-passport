// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

import { Stakeable } from "../common/Stakeable.sol";

/// @title PassportMetaFactory
/// @notice Manages the creation of Modular Smart Accounts compliant with ERC-7579 and ERC-4337 using a factory pattern.
/// @dev Utilizes the `Stakeable` for staking requirements.
///      This contract serves as a 'Meta' factory to generate new Passport instances using specific chosen and approved factories.
/// @dev Can whitelist factories, deploy accounts with chosen factory and required data for that factory.
///      The factories could possibly enshrine specific modules to avoid arbitrary execution and prevent griefing.
/// Special thanks to Biconomy, Rhinestone, and Solady team for foundational contributions
contract PassportMetaFactory is Stakeable {
    /// @notice Stores the factory addresses that are whitelisted.
    mapping(address => bool) public factoryWhitelist;

    /// @notice Error thrown when the factory is not whitelisted.
    error FactoryNotWhitelisted();

    /// @notice Error thrown when the factory address is zero.
    error InvalidFactoryAddress();

    /// @notice Error thrown when the owner address is zero.
    error ZeroAddressNotAllowed();

    /// @notice Error thrown when the call to deploy with factory failed.
    error CallToDeployWithFactoryFailed();

    /// @notice Constructor to set the owner of the contract.
    /// @param owner_ The address of the owner.
    constructor(address owner_) Stakeable(owner_) {
        require(owner_ != address(0), ZeroAddressNotAllowed());
    }

    /// @notice Adds an address to the factory whitelist.
    /// @param factory The address to be whitelisted.
    function addFactoryToWhitelist(address factory) external onlyOwner {
        require(factory != address(0), InvalidFactoryAddress());
        factoryWhitelist[factory] = true;
    }

    /// @notice Removes an address from the factory whitelist.
    /// @param factory The address to be removed from the whitelist.
    function removeFactoryFromWhitelist(address factory) external onlyOwner {
        factoryWhitelist[factory] = false;
    }

    /// @notice Deploys a new Passport with a specific factory and initialization data.
    /// @dev Uses factory.call(factoryData) to post the encoded data for the method to be called on the Factory.
    ///      These factories could enshrine specific modules to avoid arbitrary execution and prevent griefing.
    ///      Another benefit of this pattern is that the factory can be upgraded without changing this contract.
    /// @param factory The address of the factory to be used for deployment.
    /// @param factoryData The encoded data for the method to be called on the Factory.
    /// @return createdAccount The address of the newly created Passport account.
    function deployWithFactory(address factory, bytes calldata factoryData) external payable returns (address payable createdAccount) {
        require(factoryWhitelist[address(factory)], FactoryNotWhitelisted());
        (bool success, bytes memory returnData) = factory.call{ value: msg.value }(factoryData);

        // Check if the call was successful
        require(success, CallToDeployWithFactoryFailed());

        // Decode the returned address
        assembly {
            createdAccount := mload(add(returnData, 0x20))
        }
    }

    /// @notice Checks if an address is whitelisted.
    /// @param factory The address to check.
    /// @return True if the factory is whitelisted, false otherwise.
    function isFactoryWhitelisted(address factory) public view returns (bool) {
        return factoryWhitelist[factory];
    }
}
