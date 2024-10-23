[![License MIT](https://img.shields.io/badge/License-MIT-blue?&style=flat)](./LICENSE) [![Foundry](https://img.shields.io/badge/Built%20with-Foundry-FFBD10.svg)](https://getfoundry.sh/)

![Codecov Foundry Coverage](https://img.shields.io/badge/100%25-brightgreen?style=flat&logo=codecov&label=Foundry%20Coverage)

# Passport - ERC-7579 Modular Smart Account Base 🚀

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/denniswon/passport)

This repository serves as a comprehensive foundation for smart contract projects, streamlining the development process with a focus on best practices, security, and efficiency.

Documentation: (<https://github.com/denniswon/passport/wiki>)

## 📚 Table of Contents

- [Passport - ERC-7579 Modular Smart Account Base 🚀](#passport---erc-7579-modular-smart-account-base-)
  - [📚 Table of Contents](#-table-of-contents)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [🛠️ Essential Scripts](#️-essential-scripts)
    - [🏗️ Build Contracts](#️-build-contracts)
    - [🧪 Run Tests](#-run-tests)
    - [⛽ Gas Report](#-gas-report)
    - [📊 Coverage Report](#-coverage-report)
    - [📄 Documentation](#-documentation)
    - [🚀 Deploy Contracts](#-deploy-contracts)
    - [🎨 Lint Code](#-lint-code)
    - [🖌️ Auto-fix Linting Issues](#️-auto-fix-linting-issues)
  - [🔒 Security Audits](#-security-audits)
  - [🏆 Magic Champions League 🏆](#-magic-champions-league-)
    - [Champions Roster](#champions-roster)
    - [Entering the League](#entering-the-league)
  - [Documentation and Resources](#documentation-and-resources)
  - [License](#license)

## Getting Started

To kickstart, follow these steps:
To kickstart, follow these steps:

### Prerequisites

- Node.js (v18.x or later)
- Yarn (or npm)
- Foundry (Refer to [Foundry installation instructions](https://getfoundry.sh/docs/installation))

### Installation

1. **Clone the repository:**

```bash
git clone https://github.com/denniswon/passport.git
cd passport
```

2. **Install dependencies:**

```bash
yarn install
```

3. **Setup environment variables:**

Copy `.env.example` to `.env` and fill in your details.

## 🛠️ Essential Scripts

Execute key operations for Foundry with these scripts. Append `:forge` to run them in the respective environment.

### 🏗️ Build Contracts

```bash
yarn build
```

Compiles contracts for Foundry.

### 🧪 Run Tests

```bash
yarn test
```

Carries out tests to verify contract functionality.

### ⛽ Gas Report

```bash
yarn test:gas
```

Creates detailed reports for test coverage.

### 📊 Coverage Report

```bash
yarn coverage
```

Creates detailed reports for test coverage.

### 📄 Documentation

```bash
yarn docs
```

Generate documentation from NatSpec comments.

### 🚀 Deploy Contracts

```bash
yarn run deploy:forge
```

Deploys contracts onto the blockchain network.

### 🎨 Lint Code

```bash
yarn lint
```

Checks code for style and potential errors.

### 🖌️ Auto-fix Linting Issues

```bash
yarn lint:fix
```

Automatically fixes linting problems found.

## 🔒 Security Audits

| Auditor          | Date       | Final Report Link                                       |
| ---------------- | ---------- | ------------------------------------------------------- |
| CodeHawks-Cyfrin | 17-09-2024 | [View Report](./audits/CodeHawks-Cyfrin-17-09-2024.pdf) |
| Firm Name        | DD-MM-YYYY | [View Report](./audits)                                 |

## 🏆 Magic Champions League 🏆

Welcome to the Champions League, a place where your contributions to Passport are celebrated and immortalized in our Hall of Fame. This elite group showcases individuals who have significantly advanced our mission, from enhancing code efficiency to strengthening security, and enriching our documentation.

### Champions Roster

| 🍊 Contributor | 🛡️ Domain         |
| -------------- | ----------------- |
| @user1         | Code Optimization |
| @user2         | Security          |
| @user3         | Documentation     |
| ...            | ...               |

### Entering the League

Your journey to becoming a champion can start in any domain:

- **Code Wizards**: Dive into our [Gas Optimization](./GAS_OPTIMIZATION.md) efforts.
- **Security Guardians**: Enhance our safety following the [Security Guidelines](./SECURITY.md).
- **Documentation Scribes**: Elevate our knowledge base with your contributions.

The **Champions League** is not just a recognition, it's a testament to the impactful work done by our community. Whether you're optimizing gas usage or securing our contracts, your contributions help shape the future of Passport.

> **To Join**: Leave a lasting impact in your chosen area. Our Hall of Fame is regularly updated to honor our most dedicated contributors.

Let's build a legacy together, championing innovation and excellence in the blockchain space.

## Documentation and Resources

For a comprehensive understanding of our project and to contribute effectively, please refer to the following resources:

- [**Contributing Guidelines**](./CONTRIBUTING.md): Learn how to contribute to our project, from code contributions to documentation improvements.
- [**Code of Conduct**](./CODE_OF_CONDUCT.md): Our commitment to fostering an open and welcoming environment.
- [**Security Policy**](./SECURITY.md): Guidelines for reporting security vulnerabilities.
- [**Gas Optimization Program**](./GAS_OPTIMIZATION.md): Contribute towards optimizing gas efficiency of our smart contracts.
- [**Changelog**](./CHANGELOG.md): Stay updated with the changes and versions.

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
