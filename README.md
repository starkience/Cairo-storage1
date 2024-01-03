This tutorial runs on Scarb: 2.4.0, Cairo: 2.4.0, and Sierra: 1.4.0.
To install the latest version of the scarb package manager, visit this page:
Scarb is used to create a new Cairo project. 

In your project directory, you’ll have a scarb.toml containing all the information Scarb needs to compile your project.
To build the Starknet contracts, you want to add the Starknet version and the target.starknet-contract to your [dependencies]

General .toml file

.CAIRO
Like other smart contracts, a Cairo smart contract generally consists of an interplay between its functions and the contract's storage. Functions read from and write to the storage, enabling the contract to keep and update its state based on the logic of the functions.
To indicate to the compiler you want to compile a smart contract, add the #[starknet::contract] attribute. Adding attributes in Cairo is similar to adding attributes in Rust.
Whereas in solidity, we define a smart contract with:

Starknet contracts are defined within modules. 
What is a module?
Modules are a way to organize and structure our code. In the contract module, you can expect to find the contract's storage, events, and external functions.
For example, notice how the contract module encapsulates the logic of our contract, which consists of a storage attribute.

Remember how we said a smart contract is essentially the interaction between its functions and the storage?
In this case, we are defining what the storage looks like in our smart contract.
The storage variables ‘token_supply’ and ‘decimals’ are part of the contract’s state. The functions defined in the contract interact with these variables and manipulate or interact with the data stored on the blockchain. The functions are defined in our interface:
External functions 
Just like in Solidity, we can define a function as public to decide whether it is accessible from outside the contract.
The Rust-ic design of Cairo implements this feature differently than Solidity.
Cairo requires an explicit interface declaration to establish which functions will be exposed to the outside world.
It expects to see a set and get a function exposed. In general, the interface is defined before our module:

When you call the 'set' function, it changes the contract's storage. On the other hand, the 'get' function takes a snapshot of the state, which is an immutable view of a value in the storage. You can use the '@' symbol to pass the contract state as a snapshot. In Solidity, this is similar to the ‘view’ keyword.
Once we define this blueprint, it’s time to implement it in our contract. So we hop back into our module to let the contract know that we’re about to implement public functions that will modify or read the storage:

We use the #[abi(embed_v0)] attribute to tell the contract, “Hey, these functions can be called by external people.” We’re invoking a transaction here.
We have implemented the get and set functions defined in our blueprint. The set function is used to modify the storage values, and this operation incurs gas fees. On the other hand, the get function is used to read the storage values and its gas fees are much less.
To read the `stored_data` variable, we need to use `self.stored_data.read()`, where `self` refers to the ContractState type. This type is used to access the state of the deployed contract instance. We use ‘ref self: ContractState’ to indicate that we’re writing new values to the storage. On the other hand, we use ‘self @ContractState’ for functions (i.e., ‘get’) that only read the state of the contract.
If we pass an argument by reference (i.e., ‘ref’), the function can modify the value stored in the storage struct. But when we pass an argument by snapshot (i.e., using a ‘@’), the function cannot modify the storage values and only allows the user to read the state of the storage. References and snapshots in Cairo are not restricted to smart contracts.
Again, a contract defines the interaction between the storage and its functions. Well, here we are defining the public functions that, when called, will allow to alter or read the storage of the contract
Here is what we just talked about and what an entire contract will look like:

CCL: Solidity and Cairo share similar smart contract anatomy: the interaction between a contract’s storage and its functions
