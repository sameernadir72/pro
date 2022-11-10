// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
//Ownable is needed to setup sales royalties on Open Sea
//if you are the owner of the contract you can configure sales Royalties in the Open Sea website
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";

//give your contract a name
contract CryptoTraitors is ERC2981,ERC721Enumerable, Ownable {
  using Strings for uint256;

//configuration
  string baseURI;
  string public baseExtension = ".json";

//set the cost to mint each NFT
  uint256 public cost = 0.01 ether;

//set the max supply of NFT's
  uint256 public maxSupply = 10000;

//set the maximum number an address can mint at a time
  uint256 public maxMintAmount = 10000;

//is the contract paused from minting an NFT
  bool public paused = false;

//are the NFT's revealed (viewable)? If true users can see the NFTs. 
//if false everyone sees a reveal picture
  bool public revealed = true;

  uint256 public Whitelist_Price = 0.01 ether;
  mapping(address => bool) public isWhitelisted;


  bytes4 private constant _INTERFACE_ID_ERC2981 = 0x2a55205a;

  constructor(string memory _initBaseURI) ERC721("CryptoTraitors", "CT") {
    setBaseURI(_initBaseURI);
    _setDefaultRoyalty(msg.sender, 1000);
  }


  //internal function for base uri
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

    function setWhitelistCost(uint256 _whtPrice) public onlyOwner{
        Whitelist_Price = _whtPrice;
    }

    function Whitelist(address _whitelistAddress) external onlyOwner{
        isWhitelisted[_whitelistAddress] = true;
    }


  //function allows you to mint an NFT token
  function mint(uint256 _mintAmount) public payable {
    require(_mintAmount > 0);
    uint256 ts = totalSupply();
        require(ts + _mintAmount <= maxSupply, "Purchase would exceed Collection Size");
        if(isWhitelisted[msg.sender] == true){
            require(Whitelist_Price * _mintAmount<= msg.value, "Ether value sent is not correct");
            for (uint256 i = 0; i < _mintAmount; i++) {
            _safeMint(msg.sender, ts + i);
        }
        }
        else{
        //require(!paused, "Sale has'nt been started yet!");
        require(cost * _mintAmount <= msg.value, "Ether value sent is not correct");
        for (uint256 i = 0; i <= _mintAmount; i++) {
            _safeMint(msg.sender, ts + i);
        }
        }
  }

//function returns the owner
  function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

//input a NFT token ID and get the IPFS URI
  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
    
    // if(revealed == false) {
    //     return notRevealedUri;
    // }

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
  }


  //only owner
//   function reveal() public onlyOwner {
//       revealed = true;
//   }
  
//set the cost of an NFT
  function setCost(uint256 _newCost) public onlyOwner {
    cost = _newCost;
  }

//set the base URI on IPFS
  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }


  function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
    baseExtension = _newBaseExtension;
  }

//start the sale the contract and do not allow any more minting
  function startSale(bool _state) public onlyOwner {
    paused = _state;
  }
 

  function withdraw() public payable onlyOwner {
   
    (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(success);
  }

 function supportsInterface(bytes4 interfaceId)
    public view virtual override(ERC721Enumerable, ERC2981)
    returns (bool) {
      return super.supportsInterface(interfaceId);
  }

//0x4Ee2ef0bd96cff4Fdfe4d182794C82257b60CCD9
}