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
