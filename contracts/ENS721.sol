pragma solidity ^0.4.22;

import "./ERC721.sol";

contract ENS721 is ERC721 {
  constructor() public {}

  function balanceOf(address _owner) external view returns (uint256);
  function ownerOf(uint256 _tokenId) external view returns (address);

  function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
  function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

  // NOTE: This must be called by owner and pointed at 0x contract. doing this approval should also probably
  // check that the ENS contract has set this contract as its owner...?
  function approve(address _approved, uint256 _tokenId) external payable;
  function setApprovalForAll(address _operator, bool _approved) external;
  function getApproved(uint256 _tokenId) external view returns (address);
  function isApprovedForAll(address _owner, address _operator) external view returns (bool);

}
