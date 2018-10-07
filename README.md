# ENS721

ERC-721 Wrapped ENS contract for use with the 0x Protocol.

# Usage

From the _Owner_ of the domain's perspective.
1. Owner calls the `approve` method with the 0x contract address and the tokenId that represents the domain they wish to sell. There is a mapping of tokenId => node, for example `732` => foobarbaz.eth. 

This allows the 0x contract to transfer ownership.

TODO: From the _Buyer_ of the domain's perspective.

