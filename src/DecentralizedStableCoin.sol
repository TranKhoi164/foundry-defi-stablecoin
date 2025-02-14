// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >0.8.0;
import {ERC20Burnable, ERC20} from '@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';


/**
 * @title DecentralizedStableCOIN
 * @author Khoi Tran
 * @notice 
 * Colleteral: Exogenous (eth/btc)
 * minting: Algorithmic
 * Relative Stabiliby: Pegged to USD
 * Governed by DSCEngine. erc20 implementation of our stablecoin system
 */
contract DecentralizedStableCoin is ERC20Burnable, Ownable {
  error DecentralizedStableCoin_MustBeMoreThanZero();
  error DecentralizedStableCoin_BurnAmountExceedsBalance();
  error DecentralizedStableCoin_NotZeroAddress();

  constructor() ERC20 ('DecentralizedStableCoin', 'DSC') Ownable(msg.sender) {

  }

  function burn(uint256 _amount) public override onlyOwner {
    uint256 balance = balanceOf(msg.sender);
    if (_amount <= 0) {
      revert DecentralizedStableCoin_MustBeMoreThanZero();
    } 
    if (balance < _amount) {
      revert DecentralizedStableCoin_BurnAmountExceedsBalance();
    }
    super.burn(_amount);
  }

  function mint(address _to, uint256 _amount) external onlyOwner returns (bool) {
    if (_to == address(0)) {
      revert DecentralizedStableCoin_NotZeroAddress();
    }
    if (_amount <= 0) {
      revert DecentralizedStableCoin_MustBeMoreThanZero();
    }
    _mint(_to, _amount);
    return true;
  }
}