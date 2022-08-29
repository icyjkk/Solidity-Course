// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0; 

contract SimpleStorage {
     
    uint256  favoriteNumber;    //initialized to zero

    struct People {
        uint256 favoriteNumber;
        string name;
    }
    
    //People public person = People({favoriteNumber: 2, name: "Patrick"});

    People[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;     // con esto hacemos un map con clave->valor

    function store(uint256 _favoriteNumber) public {
        favoriteNumber=_favoriteNumber;
    }

    function retrieve() public view returns(uint256){  // view (read from blockchain)  pure (have some type of maths)
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {   // Memory -> data will only be stored during the execution of the function
                                                                               //  Storage-> mean that data will persist even after the function executes 
        people.push(People(_favoriteNumber,_name));    //push() para añadir objetos al array
        nameToFavoriteNumber[_name]=_favoriteNumber;
    }

}