# PhoneMarket Smart Contract

This Solidity smart contract manages a marketplace for phones on the Ethereum blockchain. It allows users to add new phones, update their prices, mark them as sold, and provides functions to test contract conditions using assert, require, and revert
## Description

The PhoneMarket smart contract facilitates a decentralized marketplace for phones on the Ethereum blockchain. Developed using Solidity ^0.8.0,
it allows users to add new phones with specific models and prices, update prices, and mark phones as sold. Administrative functions are restricted to the contract owner,
ensuring control over critical operations. The contract includes robust error handling mechanisms (assert, require, revert) to maintain data integrity and contract security. Designed for flexibility and community contributions, it supports testing functionalities to validate contract conditions and encourages enhancements through open-source collaboration. Licensed under the MIT License, the PhoneMarket contract offers a reliable foundation for managing transactions within the phone market domain on Ethereum.


## Getting Started

### Installing

To download the code, you can visit the following file path:-[        https://github.com/Paaapi/paapi/blob/main/paapi.sol  ]

### Executing program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at (https://remix.ethereum.org/.)

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., Meta.sol). Copy and paste the following code into the file: contract MyToken {

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PhoneMarket {
    struct Phone {
        string model;
        uint price;
        bool available;
    }

    mapping(uint => Phone) private phones; // Mapping of phone IDs to Phone structs
    uint private phoneCount; // Counter for phone IDs
    address private owner; // Owner of the contract (admin)

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Function to add a new phone
    function addPhone(string memory _model, uint _price) public onlyOwner {
        require(bytes(_model).length > 0, "Phone model must not be empty");
        require(_price > 0, "Phone price must be greater than zero");
        phoneCount++;
        phones[phoneCount] = Phone(_model, _price, true);
    }

    // Function to get phone details
    function getPhone(uint _id) public view returns (string memory, uint, bool) {
        require(_id > 0 && _id <= phoneCount, "Phone ID does not exist");
        Phone memory phone = phones[_id];
        return (phone.model, phone.price, phone.available);
    }

    // Function to update phone price
    function updatePrice(uint _id, uint _newPrice) public onlyOwner {
        require(_id > 0 && _id <= phoneCount, "Phone ID does not exist");
        require(_newPrice > 0, "New price must be greater than zero");
        phones[_id].price = _newPrice;
    }

    // Function to mark a phone as sold (unavailable)
    function markSold(uint _id) public onlyOwner {
        require(_id > 0 && _id <= phoneCount, "Phone ID does not exist");
        phones[_id].available = false;
    }

    // Function using assert to check a condition
    function testAssert(uint _id) public view {
        Phone memory phone = phones[_id];
        // Using assert to ensure the phone model is always not empty
        assert(bytes(phone.model).length > 0);
    }

    // Function using require to check a condition
    function testRequire(uint _id) public view {
        // Using require to ensure the phone ID exists
        require(_id > 0 && _id <= phoneCount, "Phone ID does not exist");
    }

    // Function using revert to check a condition
    function testRevert(uint _id) public view {
        // Using revert to check if the phone ID does not exist
        if (_id == 0 || _id > phoneCount) {
            revert("Phone ID does not exist");
        }
    }
}


```




## Authors

Paravdeep @papravdeep_walia(IG)


## License

This smart contract is licensed under the MIT License. See the LICENSE file for details.
