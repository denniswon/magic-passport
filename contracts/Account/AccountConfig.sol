// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { IAccountConfig } from "../interfaces/IAccountConfig.sol";

contract AccountConfig is IAccountConfig {
    /**
     * @notice Returns the account id of the smart account.
     * @return accountImplementationId The account id of the smart account.
     */
    function accountId() external view returns (string memory accountImplementationId) {
        return "ModularSmartAccount";
    }

    /**
     * @notice Checks if the account supports a certain execution mode.
     * @param encodedMode The encoded mode.
     * @return True if the account supports the mode, false otherwise.
     */
    function supportsAccountMode(bytes32 encodedMode) external view returns (bool) {
        encodedMode;
        return true;
    }

    /**
     * @notice Checks if the account supports a certain module typeId.
     * @param moduleTypeId The module type ID.
     * @return True if the account supports the module type, false otherwise.
     */
    function supportsModule(uint256 moduleTypeId) external view returns (bool) {
        moduleTypeId;
        return true;
    }
}
