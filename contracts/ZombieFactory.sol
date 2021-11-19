// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    event NewZombie(uint zombieId, string name, uint dna);

    struct Zombie{
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    function _createZombie(string _name, uint256 _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint256 rand = uint256(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
