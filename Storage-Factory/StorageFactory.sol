// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0; 

import "./SimpleStorage.sol"; // the dot and slash mean it's in the same folder

contract StorageFactory is SimpleStorage {  // this means that this code inherits from simplestorage
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();  // we create an object of type SimpleStorage. With this we managed to create a new contract
        simpleStorageArray.push(simpleStorage);       // we add the new contract to the array to have a count of all the contracts created 
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public{
        //Address
        // ABI (Aplication Binary Interface)
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));   //we create an object with the contract already created in the index position of the array
        simpleStorage.store(_simpleStorageNumber);                                                       // we call store function of simplestorage
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    }
     
}