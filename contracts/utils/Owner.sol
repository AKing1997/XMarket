// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.8.28;

abstract contract Owner {
    address private _owner;
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    modifier isOwner() {
        require(msg.sender == _owner, "Caller is not owner");
        _;
    }

    constructor() {
        _owner = msg.sender;
        emit OwnerSet(address(0), _owner);
    }

    function changeOwner(address newOwner) public isOwner {
        require(newOwner != address(0), "New owner is the zero address");
        emit OwnerSet(_owner, newOwner);
        _owner = newOwner;
    }

    function getOwner() external view returns (address) {
        return _owner;
    }
}
