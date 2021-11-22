pragma solidity ^0.8.7;
import "./ZombieHelper.sol";

contract ZombieAttack is ZombieHelper{
    uint randNonce = 0;
    uint attackVictoryProbability = 70;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(block.timestamp, msg.sender, randNonce)) % _modulus;
    }

    function attack(uint _zombieId, uint _targetId, string memory _species) external ownerOf(_zombieId) {
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        uint rand = randMod(100);
        if(rand <= attackVictoryProbability){
            myZombie.winCount++;
            myZombie.level++;
            enemyZombie.lossCount++;
            feedAndMultiply(_zombieId, _targetId, "zombie");
        }else{
            myZombie.lossCount++;
            enemyZombie.winCount++;
        }
        _triggerCooldown(myZombie);
    }
}
