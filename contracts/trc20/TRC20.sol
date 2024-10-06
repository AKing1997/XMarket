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

    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    // --- Internal functions ---
    function _transfer(address from, address to, uint256 value) internal {
        if (from == address(0)) {
            revert TRC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert TRC20InvalidReceiver(address(0));
        }
        _update(from, to, value);
    }

    function _approve(address owner, address spender, uint256 value) internal {
        _approve(owner, spender, value, true);
    }

    function _approve(
        address owner, 
        address spender, 
        uint256 value, 
        bool emitEvent
        ) internal virtual {
        if (owner == address(0)) {
            revert TRC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert TRC20InvalidSpender(address(0));
        }
        _allowances[owner][spender] = value;
        if (emitEvent) {
            emit Approval(owner, spender, value);
        }
    }

    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            if (currentAllowance < value) {
                revert TRC20InsufficientAllowance(spender, currentAllowance, value);
            }
            unchecked {
                _approve(owner, spender, currentAllowance - value, false);
            }
        }
    }

    function _update(address from, address to, uint256 value) internal virtual {
        if (from == address(0)) {
            _totalSupply += value;
        } else {
            uint256 fromBalance = _balances[from];
            if (fromBalance < value) {
                revert TRC20InsufficientBalance(from, fromBalance, value);
            }
            unchecked {
                _balances[from] = fromBalance - value;
            }
        }

        if (to == address(0)) {
            unchecked {
                _totalSupply -= value;
            }
        } else {
            unchecked {
                _balances[to] += value;
            }
        }

        emit Transfer(from, to, value);
    }

    function _mint(address account, uint256 value) isOwner() internal {
        if (account == address(0)) {
            revert TRC20InvalidReceiver(address(0));
        }
        _update(address(0), account, value);
    }

    function _burn(address account, uint256 value) isOwner() internal {
        if (account == address(0)) {
            revert TRC20InvalidSender(address(0));
        }
        _update(account, address(0), value);
    }
}