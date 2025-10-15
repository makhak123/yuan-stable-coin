// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title YuanCoin (CNYS)
 * @dev A stablecoin pegged to the Chinese Yuan (CNY)
 * Similar to USDC but for Yuan
 */
contract YuanCoin is ERC20, ERC20Burnable, ERC20Pausable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant BLACKLISTER_ROLE = keccak256("BLACKLISTER_ROLE");

    mapping(address => bool) private _blacklisted;

    event Blacklisted(address indexed account);
    event UnBlacklisted(address indexed account);
    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed from, uint256 amount);

    constructor() ERC20("Yuan Coin", "CNYS") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(BLACKLISTER_ROLE, msg.sender);
    }

    /**
     * @dev Returns the number of decimals used for token amounts.
     * USDC uses 6 decimals, so we follow the same pattern.
     */
    function decimals() public pure override returns (uint8) {
        return 6;
    }

    /**
     * @dev Mints new tokens. Only accounts with MINTER_ROLE can call this.
     * @param to The address that will receive the minted tokens
     * @param amount The amount of tokens to mint (in smallest unit)
     */
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        require(!_blacklisted[to], "YuanCoin: recipient is blacklisted");
        _mint(to, amount);
        emit Mint(to, amount);
    }

    /**
     * @dev Burns tokens from the caller's account
     * @param amount The amount of tokens to burn
     */
    function burn(uint256 amount) public override {
        super.burn(amount);
        emit Burn(msg.sender, amount);
    }

    /**
     * @dev Burns tokens from a specified account (requires allowance)
     * @param account The account to burn tokens from
     * @param amount The amount of tokens to burn
     */
    function burnFrom(address account, uint256 amount) public override {
        super.burnFrom(account, amount);
        emit Burn(account, amount);
    }

    /**
     * @dev Pauses all token transfers. Only PAUSER_ROLE can call this.
     */
    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /**
     * @dev Unpauses all token transfers. Only PAUSER_ROLE can call this.
     */
    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /**
     * @dev Adds an address to the blacklist. Only BLACKLISTER_ROLE can call this.
     * @param account The address to blacklist
     */
    function blacklist(address account) public onlyRole(BLACKLISTER_ROLE) {
        require(!_blacklisted[account], "YuanCoin: account already blacklisted");
        _blacklisted[account] = true;
        emit Blacklisted(account);
    }

    /**
     * @dev Removes an address from the blacklist. Only BLACKLISTER_ROLE can call this.
     * @param account The address to remove from blacklist
     */
    function unBlacklist(address account) public onlyRole(BLACKLISTER_ROLE) {
        require(_blacklisted[account], "YuanCoin: account not blacklisted");
        _blacklisted[account] = false;
        emit UnBlacklisted(account);
    }

    /**
     * @dev Checks if an address is blacklisted
     * @param account The address to check
     * @return bool True if the address is blacklisted
     */
    function isBlacklisted(address account) public view returns (bool) {
        return _blacklisted[account];
    }

    /**
     * @dev Hook that is called before any transfer of tokens.
     * Prevents blacklisted addresses from sending or receiving tokens.
     */
    function _update(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Pausable) {
        require(!_blacklisted[from], "YuanCoin: sender is blacklisted");
        require(!_blacklisted[to], "YuanCoin: recipient is blacklisted");
        super._update(from, to, amount);
    }
}
