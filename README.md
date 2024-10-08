# XRealEstate Smart Contracts

**XRealEstate** is a decentralized real estate platform that facilitates the tokenization and trading of real-world assets using smart contracts deployed on the Tron blockchain. The platform uses TRC20 and TRC721 standards to manage real estate tokens and assets, with built-in functionality for user verification via **DigitalIdentity**.

## Table of Contents

- [Project Structure](#project-structure)
- [Contracts Overview](#contracts-overview)
- [Deployment Information](#deployment-information)
- [Testing and Interaction](#testing-and-interaction)
- [Get Free TRX for Shasta Testnet](#get-free-trx-for-shasta-testnet)

## Project Structure

The contracts are organized into different directories and follow modular architecture for easy scaling and maintenance. Here is an overview of the 
project structure:
```
│   DigitalIdentity.sol // Handles KYC and user verification
│   Market.sol // Manages property buying and selling
│   Migrations.sol  // Migration contract for deployment
│   RealEstateAsset.sol  // Tokenizes real estate as TRC721 NFTs 
│   RealEstateToken.sol  // TRC20 tokens representing ownership of assets
│   
├───trc20  // Implements TRC20 token standards
│       ITRC20.sol
│       ITRC20Errors.sol
│       ITRC20Metadata.sol
│       TRC20.sol
│       
├───trc721  // Implements TRC721 NFT standards
│   │   TRC721.sol
│   │   
│   ├───interfaces
│   │       ITRC721.sol
│   │       ITRC721Enumerable.Sol
│   │       ITRC721Errors.sol
│   │       ITRC721Metadata.sol
│   │       ITRC721Receiver.sol
│   │       
│   └───utils 
│           TRC721Utils.sol
│
└───utils // Utility contracts for common operations
    │   Context.sol
    │   Ownable.sol
    │   Strings.sol
    │   
    ├───introspection // Supports interface identification
    │       ITRC165.sol
    │       TRC165.sol
    │
    └───math // Math utilities for safe calculations
            Math.sol
            SafeCast.sol
            SignedMath.sol
```
## Contracts Overview

### 1. **DigitalIdentity.sol**
   - Manages user identity and KYC (Know Your Customer) verification.
   - Only verified users can interact with the system to create, buy, or sell real estate assets.

### 2. **RealEstateToken.sol**
   - Implements a TRC20 token that represents ownership in real estate properties.
   - Each token is linked to a specific asset.

### 3. **RealEstateAsset.sol**
   - Implements a TRC721 standard contract to tokenize real-world real estate assets as NFTs.
   - Each asset can be bought, sold, or transferred only by verified users.

### 4. **Market.sol**
   - Facilitates the creation of a decentralized marketplace where verified users can list, buy, or sell real estate assets tokenized as NFTs.
   - Integrates with both the TRC20 token (RealEstateToken) and the TRC721 standard (RealEstateAsset) for seamless transactions.

### 5. **Migrations.sol**
   - Standard migration contract used to handle deployments.

### TRC20 and TRC721 Implementations
- **TRC20**: Includes the `TRC20.sol` implementation and required interfaces such as `ITRC20.sol`, `ITRC20Metadata.sol`.
- **TRC721**: Implements `TRC721.sol` and necessary utility and interface contracts such as `ITRC721.sol`, `TRC721Utils.sol`, etc.

### Utility Contracts
- **Context.sol**: Provides execution context, including information about the current sender and transaction data.
- **Ownable.sol**: Implements basic access control, where the contract owner can be granted exclusive privileges.
- **Math.sol**: Safe math operations, casting utilities, and signed math.

## Deployment Information

The contracts have been deployed on the **Nile Testnet**. Below are the deployed contract addresses:

- **Migrations**:
  - Base58: `TESwu1FFLbGLNB6JranN42DdSnji6yU1R3`
  - Hex: `41311f8aa40243c66ec44b3e532d33e4ec39515d04`

- **DigitalIdentity**:
  - Base58: `TLMsMxLtt3wrarUs9JHbSC7oNpdb4FdAGJ`
  - Hex: `4171fa6e380fdccfc0455158df0bb3cc3d95eade7c`

- **RealEstateToken**:
  - Base58: `TCfs2yAR2U1yjK8TyH49zjzWkpGumMSqFr`
  - Hex: `411da0a369cb36e68881547d5a29c6d84430a0e10f`

- **RealEstateAsset**:
  - Base58: `TNPFgBB2hBXHZPbJvh9uUmqciZuEtrPtTM`
  - Hex: `41882db99933c3aa79c1a827b850cb94e1c374f543`

- **Market**:
  - Base58: `TBPLWiaL3eyZS2v6rpdpTTij3ftffKMS1E`
  - Hex: `410f8861082591a7839120cbb4040126ab2ef5d4dd`

## Testing and Interaction

To interact with the contracts on the **Nile Testnet**, you can use TronLink or similar Tron-compatible wallets. 

- **For testing**:
  1. Deploy contracts on the testnet using TronBox.
  2. Ensure the user is verified using **DigitalIdentity** before allowing any asset creation, purchase, or sale.
  3. Use **RealEstateToken** for fractional ownership and **RealEstateAsset** for full property NFTs.

- **Market Interactions**:
  - Only verified users can list assets on the marketplace.
  - Asset purchases are done using the TRC20-based **RealEstateToken**.

## Get Free TRX for Shasta Testnet

To get free TRX for testing on the **Shasta Testnet**, visit [Shasta Tronex](https://shasta.tronex.io/)
To get free TRX for testing on the **Nile Testnet**, visit [Nile Tronex](https://nileex.io/join/getJoinPage)