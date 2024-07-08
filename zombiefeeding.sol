pragma solidity>=0.5.0 < 0.6.0;
import "./zombiefactory.sol";

//Creating kittyInterface
contract kittyInterface{
    function getKitty(uint256 _id) public view returns(
      bool isGestating,
      bool isReady,
      uint256 cooldownIndex,
      uint256 nextActionAt,
      uint256 siringWithId,
      uint256 birthTime,
      uint256 matronId,
      uint256 sireId,
      uint256 generation,
      uint256 genes;
    );
}

contract zombieFeeding is ZombieFactory {

    kittyInterface kittyContract;
    function setKittyContractAddress(address _address) external onlyOwner{
       kittyContract = kittyInterface(_address);
    }

    function _triggerCooldown(Zombie storage _zombie) internal {
      _zombie.readyTime = uint32(now + cooldownTime);      
    }

    function _isReady(Zombie storage _zombie) internal view returns(bool){
      return (_zombie.readyTime <= now);
    }



    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
      require(msg.sender == zombieToOwner[_zombieId]); // Authenticating
      Zombie storage myZombie = zombies[_zombieId]
      require(_isReady(myZombie));
      _targetDna = _targetDna % dnaModulus;
      uint newDna = (myZombie.dna + _targetDna) / 2; // Average of zombie's dna and target dna
      if(keccak256(abi.encodePacked(_specied)) == keccak256(abi.encode("kitty"))){
        newDna = newDna - newDna % 100 + 99;
      }
      _createZombie("NoName", newDna); //creating a zombie
      _triggerCooldown(myZombie);
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna);

    }


}