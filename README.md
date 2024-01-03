# Scarb, Cairo, and Sierra Tutorial

This tutorial is compatible with:
- **Scarb**: `2.4.0`
- **Cairo**: `2.4.0`
- **Sierra**: `1.4.0`

## Installation

To install the latest version of the scarb package manager, visit [Scarb Installation Page](<link-to-scarb>).

## Setting Up a Cairo Project

In your project directory, you'll find a `scarb.toml` file containing all necessary information for Scarb to compile your project. 

### Building Starknet Contracts

To build Starknet contracts, add the Starknet version and `target.starknet-contract` to your `[dependencies]` in the `.toml` file.

## Understanding Cairo Smart Contracts

### The .CAIRO File

A Cairo smart contract, similar to other smart contracts, involves functions interacting with the contract's storage. These functions enable the contract to maintain and update its state.

#### Adding the `#[starknet::contract]` Attribute

To compile a smart contract in Cairo, add the `#[starknet::contract]` attribute. This is akin to declaring a smart contract in Solidity.

### Starknet Contract Structure

#### Modules

Modules in Starknet organize code, encompassing the contract's storage, events, and external functions. 

#### Storage

Consider the storage variables `token_supply` and `decimals` as part of the contract’s state. Functions in the contract interact with these variables, manipulating or interacting with data on the blockchain.

### External Functions

In Cairo, functions are public by default. However, an explicit interface declaration is required to expose certain functions externally. Define a set and get function in the interface before the contract module.

#### Implementation

Use the `#[abi(embed_v0)]` attribute to allow external access to functions. Implement the set and get functions as defined. Note that the set function incurs gas fees due to storage modifications, while the get function, used for reading storage values, incurs lower gas fees.

#### Reading Stored Data

Use `self.stored_data.read()` to read the `stored_data` variable, where `self` refers to the `ContractState` type.

### Contract Interaction

A contract defines the interaction between its storage and functions. The public functions allow modification or reading of the contract's storage.


