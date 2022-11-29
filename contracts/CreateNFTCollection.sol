// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "./Erc721.sol";

contract CreateNFTCollection is Erc721{
  string private _name;
  string private _symbol;
  uint256 private _tokenId;
  // object to hold the uri for tokens
  mapping(uint256 => string) _tokenURIs;
  
  constructor(string memory name_, string memory symbol_){
    _name = name_;
    _symbol = symbol_;
  }

  function name() external view returns(string memory) {
    return _name;
  }

  function symbol() external view returns(string memory) {
    return _symbol;
  }

  function tokenURIs(uint256 _tokenId) external view returns (string memory) {
    // check if token is valid
    require(_ownerOf[_tokenId] == address(0), "Invalid Token");

    return _tokenURIs[_tokenId];
  }

  /*
  Add a NFT in the collection
    - update balance of sender/caller
    - update owner of token
    - update tokenURI of token
  */ 
  function mint(string memory _tokenURI) external { 
    _balanceOf[msg.sender] += 1;
    _ownerOf[_tokenId] = msg.sender;
    _tokenURIs[_tokenId] = _tokenURI;
    emit Transfer(address(0), msg.sender, _tokenId);

    _tokenId += 1;
  }

  function supportsInterface(bytes4 _interfaceId) public pure override returns(bool) {
      return _interfaceId == 0x80ac58cd || _interfaceId == 0x5b5e139f;
    }
}

