pragma solidity>=0.5.0 < 0.6.0;
import "./zombiefactory.sol";
contract zombieFeeding is ZombieFactory {


    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
      require(msg.sender == zombieToOwner[_zombieId]); // Authenticating
      Zombie storage myZombie = zombies[_zombieId]
      _targetDna = _targetDna % dnaModulus;
      uint newDna = (myZombie.dna + _targetDna) / 2; // Average of zombie's dna and target dna
      _createZombie("NoName", newDna); //creating a zombie
    }


}