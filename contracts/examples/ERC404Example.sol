//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ERC404} from "../ERC404.sol";

contract ERC404Example is Ownable, ERC404 {
  string public dataURI;
  string public baseTokenURI;

  constructor(
    string memory name_,
    string memory symbol_,
    uint8 mu_,
    uint256 maxTotalSupplyERC721_,
    address initialOwner_,
    address initialMintRecipient_
  ) ERC404(name_, symbol_, mu_) Ownable(initialOwner_) {
    // Do not mint the ERC721s to the initial owner, as it's a waste of gas.
    _setERC721TransferExempt(initialMintRecipient_, true);
    _mintERC20(initialMintRecipient_, maxTotalSupplyERC721_ * _unit());
  }

  function setDataURI(string memory _dataURI) public onlyOwner {
    dataURI = _dataURI;
  }

  function setTokenURI(string memory _tokenURI) public onlyOwner {
    baseTokenURI = _tokenURI;
  }

  function setERC721TransferExempt(
    address account_,
    bool value_
  ) external onlyOwner {
    _setERC721TransferExempt(account_, value_);
  }

  function tokenURI(uint256 id) public view override returns (string memory) {
    if (bytes(baseTokenURI).length > 0) {
      return string.concat(baseTokenURI, Strings.toString(id));
    } else {
      uint8 seed = uint8(bytes1(keccak256(abi.encodePacked(id))));
      string memory image;
      string memory color;

      if (seed <= 100) {
        image = "1.gif";
        color = "Green";
      } else if (seed <= 160) {
        image = "2.gif";
        color = "Blue";
      } else if (seed <= 210) {
        image = "3.gif";
        color = "Purple";
      } else if (seed <= 240) {
        image = "4.gif";
        color = "Orange";
      } else if (seed <= 255) {
        image = "5.gif";
        color = "Red";
      }

      string memory jsonPreImage = string.concat(
        string.concat(
          string.concat(
            '{"name": "Test #',
            Strings.toString(id - ID_ENCODING_PREFIX)
          ),
          '","description":"alwjdaoiwdj.","external_url":"https://pdawdasdd","image":"'
        ),
        string.concat(dataURI, image)
      );
      string memory jsonPostImage = string.concat(
        '","attributes":[{"trait_type":"Color","value":"',
        color
      );
      string memory jsonPostTraits = '"}]}';

      return
        string.concat(
          "data:application/json;utf8,",
          string.concat(
            string.concat(jsonPreImage, jsonPostImage),
            jsonPostTraits
          )
        );
    }
  }
}
