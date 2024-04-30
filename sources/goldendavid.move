module goldendavid::goldendavid {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use std::ascii;
    use sui::url;
    use sui::tx_context::{Self, TxContext};

    /// The type identifier of coin. The coin will have a type
    /// tag of kind: `Coin<package_object::mycoin::MYCOIN>`
    /// Make sure that the name of the type matches the module's name.
    struct GOLDENDAVID has drop {}

    /// Module initializer is called once on module publish. A treasury
    /// cap is sent to the publisher, who then controls minting and burning
    fun init(witness: GOLDENDAVID, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            witness,
            0,
            b"GOLDEN",
            b"",
            b"",
            option::none(),
            ctx
        );
        transfer::public_transfer(metadata, tx_context::sender(ctx));
        transfer::public_transfer(treasury, tx_context::sender(ctx))   
    }
    
   
/*     public entry fun update_icon_url(
        _treasury: &coin::TreasuryCap<GOLDENDAVID>, 
        metadata: &mut coin::CoinMetadata<GOLDENDAVID>, 
        url: ascii::String
        ){
        metadata.icon_url=option::some(url::new_unsafe(url));
    } */

    public fun mint(
    treasury_cap: &mut TreasuryCap<GOLDENDAVID>, 
    amount: u64, 
    recipient: address, 
    ctx: &mut TxContext,
    ) {
        let coin = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(coin, recipient);
    }
    

}