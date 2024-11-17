module Interoperablegamingassetstanadard  ::GamingAssets {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct representing a gaming asset.
    struct GamingAsset has store, key {
        owner: address,     // Owner of the asset
        asset_id: u64,      // Unique identifier for the asset
        value: u64,         // Value or importance of the asset
    }

    /// Function to create a new gaming asset.
    public fun create_asset(owner: &signer, asset_id: u64, value: u64) {
        let asset = GamingAsset {
            owner: signer::address_of(owner),
            asset_id,
            value,
        };
        move_to(owner, asset);
    }

    /// Function to transfer an asset to another user.
    public fun transfer_asset(sender: &signer, recipient: address, asset_id: u64) acquires GamingAsset {
        let asset = borrow_global_mut<GamingAsset>(signer::address_of(sender));

        // Ensure that the sender is the current owner of the asset
        assert!(asset.owner == signer::address_of(sender), 1);

        // Transfer ownership to the recipient
        asset.owner = recipient;
    }
}
