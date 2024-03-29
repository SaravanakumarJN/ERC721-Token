// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "./Erc721.sol";

contract CreateNFTCollection is Erc721 {
    string private _name;
    string private _symbol;
    uint256 private _tokenId;
    // object to hold the uri for tokens
    mapping(uint256 => string) _tokenURIs;
    struct NftDetails {
        uint256 amount;
        bool forSale;
        string tokenURI;
    }
    mapping(uint256 => NftDetails) _nftDetails;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function tokenURI(uint256 tokenId_) external view returns (string memory) {
        // check if token is valid
        require(_ownerOf[tokenId_] != address(0), "Invalid Token");

        return _tokenURIs[tokenId_];
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

    function sellNft(uint256 tokenId_, uint256 _amount) external {
        require(_ownerOf[tokenId_] != address(0), "Invalid token Id");
        require(msg.sender == _ownerOf[tokenId_], "Unauthorised");
        _nftDetails[tokenId_] = NftDetails({
            amount: _amount,
            forSale: true,
            tokenURI: _tokenURIs[tokenId_]
        });
    }

    function buyNft(uint256 tokenId_) public payable {
        require(_ownerOf[tokenId_] != address(0), "Invalid token Id");
        NftDetails storage nft = _nftDetails[tokenId_];
        require(nft.forSale == true, "NFT is not for sale");
        require(msg.value >= nft.amount, "Insufficient funds to purchase NFT");
        address payable owner = payable(ownerOf(tokenId_));
        owner.transfer(msg.value);
        safeTransferFrom(owner, msg.sender, tokenId_, "");
        _nftDetails[tokenId_] = NftDetails(0, false, nft.tokenURI);
    }

    function supportsInterface(
        bytes4 _interfaceId
    ) public pure override returns (bool) {
        return _interfaceId == 0x80ac58cd || _interfaceId == 0x5b5e139f;
    }
}
