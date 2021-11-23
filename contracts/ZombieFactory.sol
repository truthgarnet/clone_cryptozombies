pragma solidity ^0.8.10;

import "./Ownable.sol";
import "./SafeMath.sol";

contract ZombieFactory is Ownable{

    using SafeMath for uint256;

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint coolDownTime = 1 days;

    struct Zombie{
        string name;
        uint256 dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint256 _dna, uint32 level, uint32 cooldownTime, uint16 winCount, uint16 lossCount) internal {
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0)) - 1;
        NewZombie(id, _name, _dna);
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
    }

    function _generateRandomDna(string memory _str) internal view returns (uint) {
        uint256 rand = uint256(keccak256((abi.encodePacked(_str))));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}