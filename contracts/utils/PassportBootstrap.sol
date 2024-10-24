// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Passport: A suite of contracts for Modular Smart Accounts compliant with ERC-7579 and ERC-4337

import { ModuleManager } from "../base/ModuleManager.sol";
import { IModule } from "../interfaces/modules/IModule.sol";
import { IERC7484 } from "../interfaces/IERC7484.sol";

/// @title PassportBootstrap Configuration for Passport
/// @notice Provides configuration and initialization for Passport smart accounts.
/// Special thanks to Biconomy, Rhinestone, and Solady team for foundational contributions
struct BootstrapConfig {
    address module;
    bytes data;
}

/// @title PassportBootstrap
/// @notice Manages the installation of modules into Passport smart accounts using delegatecalls.
contract PassportBootstrap is ModuleManager {
    /// @notice Initializes the Passport account with a single validator.
    /// @dev Intended to be called by the Passport with a delegatecall.
    /// @param validator The address of the validator module.
    /// @param data The initialization data for the validator module.
    function initPassportWithSingleValidator(
        IModule validator,
        bytes calldata data,
        IERC7484 registry,
        address[] calldata attesters,
        uint8 threshold
    )
        external
    {
        _configureRegistry(registry, attesters, threshold);
        _installValidator(address(validator), data);
    }

    /// @notice Initializes the Passport account with multiple modules.
    /// @dev Intended to be called by the Passport with a delegatecall.
    /// @param validators The configuration array for validator modules.
    /// @param executors The configuration array for executor modules.
    /// @param hook The configuration for the hook module.
    /// @param fallbacks The configuration array for fallback handler modules.
    function initPassport(
        BootstrapConfig[] calldata validators,
        BootstrapConfig[] calldata executors,
        BootstrapConfig calldata hook,
        BootstrapConfig[] calldata fallbacks,
        IERC7484 registry,
        address[] calldata attesters,
        uint8 threshold
    )
        external
    {
        _configureRegistry(registry, attesters, threshold);

        // Initialize validators
        for (uint256 i = 0; i < validators.length; i++) {
            _installValidator(validators[i].module, validators[i].data);
        }

        // Initialize executors
        for (uint256 i = 0; i < executors.length; i++) {
            if (executors[i].module == address(0)) continue;
            _installExecutor(executors[i].module, executors[i].data);
        }

        // Initialize hook
        if (hook.module != address(0)) {
            _installHook(hook.module, hook.data);
        }

        // Initialize fallback handlers
        for (uint256 i = 0; i < fallbacks.length; i++) {
            if (fallbacks[i].module == address(0)) continue;
            _installFallbackHandler(fallbacks[i].module, fallbacks[i].data);
        }
    }

    /// @notice Initializes the Passport account with a scoped set of modules.
    /// @dev Intended to be called by the Passport with a delegatecall.
    /// @param validators The configuration array for validator modules.
    /// @param hook The configuration for the hook module.
    function initPassportScoped(
        BootstrapConfig[] calldata validators,
        BootstrapConfig calldata hook,
        IERC7484 registry,
        address[] calldata attesters,
        uint8 threshold
    )
        external
    {
        _configureRegistry(registry, attesters, threshold);

        // Initialize validators
        for (uint256 i = 0; i < validators.length; i++) {
            _installValidator(validators[i].module, validators[i].data);
        }

        // Initialize hook
        if (hook.module != address(0)) {
            _installHook(hook.module, hook.data);
        }
    }

    /// @notice Prepares calldata for the initPassport function.
    /// @param validators The configuration array for validator modules.
    /// @param executors The configuration array for executor modules.
    /// @param hook The configuration for the hook module.
    /// @param fallbacks The configuration array for fallback handler modules.
    /// @return init The prepared calldata for initPassport.
    function getInitPassportCalldata(
        BootstrapConfig[] calldata validators,
        BootstrapConfig[] calldata executors,
        BootstrapConfig calldata hook,
        BootstrapConfig[] calldata fallbacks,
        IERC7484 registry,
        address[] calldata attesters,
        uint8 threshold
    )
        external
        view
        returns (bytes memory init)
    {
        init = abi.encode(address(this), abi.encodeCall(this.initPassport, (validators, executors, hook, fallbacks, registry, attesters, threshold)));
    }

    /// @notice Prepares calldata for the initPassportScoped function.
    /// @param validators The configuration array for validator modules.
    /// @param hook The configuration for the hook module.
    /// @return init The prepared calldata for initPassportScoped.
    function getInitPassportScopedCalldata(
        BootstrapConfig[] calldata validators,
        BootstrapConfig calldata hook,
        IERC7484 registry,
        address[] calldata attesters,
        uint8 threshold
    )
        external
        view
        returns (bytes memory init)
    {
        init = abi.encode(address(this), abi.encodeCall(this.initPassportScoped, (validators, hook, registry, attesters, threshold)));
    }

    /// @notice Prepares calldata for the initPassportWithSingleValidator function.
    /// @param validator The configuration for the validator module.
    /// @return init The prepared calldata for initPassportWithSingleValidator.
    function getInitPassportWithSingleValidatorCalldata(
        BootstrapConfig calldata validator,
        IERC7484 registry,
        address[] calldata attesters,
        uint8 threshold
    )
        external
        view
        returns (bytes memory init)
    {
        init = abi.encode(
            address(this), abi.encodeCall(this.initPassportWithSingleValidator, (IModule(validator.module), validator.data, registry, attesters, threshold))
        );
    }

    /// @dev EIP712 domain name and version.
    function _domainNameAndVersion() internal pure override returns (string memory name, string memory version) {
        name = "PassportBootstrap";
        version = "1.0.0-beta.1";
    }
}
