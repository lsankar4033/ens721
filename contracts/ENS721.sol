pragma solidity ^0.4.22;

import "./ERC721.sol";

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
    string constant ensAddress = "0x112234455c3a32fd11230c42e7bccd4a84e02010";
    string constant zeroXAddress = "0xe41d2489571d322189246dafa5ebde1f4699f498";
    mapping(uint256 => address) public tokenIdToOwner;
    mapping(uint256 => mapping(address => bool)) public addressToTokenId;
    // mapping of tokenId to node (hash of ENS name) tokenIdToNode

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
          // check approve
          // require(approvalMap[tokenId][msg.sender])
          // tokenIdToOwner[_tokenId] = _to;
        }
        // TODO: Set the new owner on the ENS setOwner(tokenIdToNode(_tokenId), _to) 
    }

    // NOTE: This must be called by owner and pointed at 0x contract. doing this approval should also probably
    // check that the ENS contract has set this contract as its owner...?
    function approve(address _approved, uint256 _tokenId) external payable {
        // check that approved === 0x contract address
        // make sure sender owns token 
        // check that there's a node for this tokenId
        // check that this contract is owner of node corresponding to owner on that contract
        // approvalMap[tokenId][approved] = true
    }
    function setApprovalForAll(address _operator, bool _approved) external;
    function getApproved(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);

}
