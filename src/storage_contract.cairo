#[starknet::interface]
trait ISimpleStorage<TContractState> {
    fn set(ref self: TContractState, number: u128);
    fn get(self: @TContractState) -> u128;
}

#[starknet::contract]
mod SimpleStorage {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        stored_data: u128
    }

    #[abi(embed_v0)]
    impl SimpleStorage of super::ISimpleStorage<ContractState> {
        fn set(ref self: ContractState, number: u128) {
            self.stored_data.write(number);
        }
        fn get(self: @ContractState) -> u128 {
            self.stored_data.read()
        }
    }
}



