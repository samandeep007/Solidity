pragma solidity>=0.5.0 < 0.6.0;
import "./zombiefactory.sol";
contract zombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetId) public {
      require(msg.sender == zombieToOwner[_zombieId]);
      Zombie storage myZombie = Zombies[_zombieId]
    }
}