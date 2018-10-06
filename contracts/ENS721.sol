pragma solidity ^0.4.22;

import "./ERC721.sol";

contract ENS {
    function setOwner(bytes32 node, address owner) external;
    function owner(bytes32 node) external view returns (address);
}

// use infura ropsten 
contract ENS721 is ERC721 {

    // ENS methods (for reference):
    // get:
    //  - owner(node)
    //  - resolver(node)
    //  - ttl(node)
    // put:
    //  - setSubnodeOwner(node, label, owner)
    //  - setTTL(node, ttl)
    //  - setResolver(node, resolver)
    //  - setOwner(node, owner)
    // Ropsten address
    // address ensAddress = 0x112234455c3a32fd11230c42e7bccd4a84e02010;
    ENS ensInstance = ENS(0x112234455c3a32fd11230c42e7bccd4a84e02010);
    // Ropsten address acccording to https://blog.0xproject.com/canonical-weth-a9aa7d0279dd 
    address zeroXAddress = 0xc778417e063141139fce010982780140aa0cd5ab;
    // hardcoded for now
    bytes32 node = "foobar123.eth";

    mapping(uint256 => address) public tokenIdToOwner;
    mapping(uint256 => mapping(address => bool)) public tokenIdToAddress;
    // mapping of tokenId to node (hash of ENS name) tokenIdToNode
    mapping(uint256 => bytes32) public tokenIdToNode;
    // approval mapping of tokenId to owner's address
    mapping(uint256 => mapping(address => bool)) public tokenIdToApproval;

    constructor() public {}

    function balanceOf(address _owner) external view returns (uint256);
    function ownerOf(uint256 _tokenId) external view returns (address);

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        require (tokenIdToOwner[_tokenId] == _from);
        if (msg.sender == _from){
            tokenIdToOwner[_tokenId] = _to;
        } else {
            // check approval
            require(tokenIdToApproval[_tokenId][msg.sender] == true);
            tokenIdToOwner[_tokenId] = _to;
        }
        tokenIdToNode[_tokenId] = node;
        // Set the new owner on the ENS setOwner(tokenIdToNode(_tokenId), _to) 
        // TODO: Use keccak
        // ensAddress.call(bytes4(sha3("setOwner(bytes32,address)")), tokenIdToNode[_tokenId], _to);
        ensInstance.setOwner(tokenIdToNode[_tokenId], _to);
    }

    // NOTE: This must be called by owner and pointed at 0x contract. doing this approval should also probably
    // check that the ENS contract has set this contract as its owner...?
    function approve(address _approved, uint256 _tokenId) external payable {
        // check that approved == 0x contract address for now
        require(_approved == zeroXAddress);
        // make sure sender owns token 
        require(tokenIdToOwner[_tokenId] == msg.sender);
        // check that there's a node for this tokenId
        require(tokenIdToNode[_tokenId] == node);
        // check that this contract is owner of node corresponding to owner on that contract
        // require(ensAddress.call(bytes4(sha3("owner(node)")), node) == address(this));
        require(ensInstance.owner(node) == address(this));
        // approvalMap[tokenId][approved] = true
        tokenIdToApproval[_tokenId][_approved] = true;
    }
    function setApprovalForAll(address _operator, bool _approved) external;
    function getApproved(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);

}
