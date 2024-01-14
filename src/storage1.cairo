#[starknet::interface]
trait ISimpleStorage<TContractState> {
    fn set(ref self: TContractState, x: felt252);
    fn get(self: @TContractState) -> felt252;
}

#[starknet::contract]
mod SimpleStorage {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        stored_data: felt252
    }

    #[abi(embed_v0)]
    impl SimpleStorage of super::ISimpleStorage<ContractState> {
        fn set(ref self: ContractState, x: felt252) {
            self.stored_data.write(x);
        }
        fn get(self: @ContractState) -> felt252 {
            self.stored_data.read()
        }
    }
}
