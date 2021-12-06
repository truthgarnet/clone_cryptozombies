pragma solidity ^0.8.10;

abstract contract Erc721 {
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

    function balanceOf(address _owner) external virtual view returns (uint256 _balance);
    function ownerOf(uint256 _tokenId) external virtual view returns (address _owner);
    function transfer(address _to, uint256 _tokenId) external virtual;
    function approve(address _to, uint256 _tokenId) external virtual;
    function takeOwnership(uint256 _tokenId) external virtual;
}
