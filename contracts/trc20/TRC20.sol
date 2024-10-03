// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;

import {ITRC20} from "./ITRC20.sol";
import {ITRC20Metadata} from "./ITRC20Metadata.sol";
import {Context} from "./../utils/Context.sol";
import {Owner} from "./../utils/Owner.sol";
import {ITRC20Errors} from "./ITRC20Errors.sol";

contract TRC20 is Context, Owner, ITRC20, ITRC20Metadata, ITRC20Errors {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(string memory name_, string memory symbol_, uint8 decimals_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }

    // --- ITRC20Metadata implementation ---
    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    // --- ITRC20 implementation ---
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner_, address spender) public view override returns (uint256) {
        return _allowances[owner_][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()] - amount);
        return true;
    }

    // --- Internal functions ---
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        if (sender == address(0)) {
            revert TRC20InvalidSender(sender);
        }
        if (recipient == address(0)) {
            revert TRC20InvalidReceiver(recipient);
        }

        uint256 senderBalance = _balances[sender];
        if (senderBalance < amount) {
            revert TRC20InsufficientBalance(sender, senderBalance, amount);
        }
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }

    function _approve(
        address owner_,
        address spender,
        uint256 amount
    ) internal {
        if (owner_ == address(0)) {
            revert TRC20InvalidApprover(owner_);
        }
        if (spender == address(0)) {
            revert TRC20InvalidSpender(spender);
        }

        _allowances[owner_][spender] = amount;
        emit Approval(owner_, spender, amount);
    }

    function mint(address account, uint256 amount) public isOwner {
        require(account != address(0), "TRC20: mint to the zero address");

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function burn(uint256 amount) public isOwner {
        require(amount > 0, "TRC20: burn amount must be greater than zero");
        require(_balances[msg.sender] >= amount, "TRC20: burn amount exceeds balance");

        _balances[msg.sender] -= amount;
        _totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "TRC20: decreased allowance below zero");
        _approve(_msgSender(), spender, currentAllowance - subtractedValue);
        return true;
    }
}