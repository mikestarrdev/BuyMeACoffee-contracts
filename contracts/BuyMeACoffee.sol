//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Deployed to Goerli at 0x310e8362A1f405BD89B8a7471471CA07e5730f9e

contract BuyMeACoffee {
    // Event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // List of all memos received from friends
    Memo[] memos;

    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    /*
    * @dev buy a coffee for contract owner
    * @param _name name of coffee buyer
    * @param _message a nice message for the coffee buyer
    */
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "Can't buy coffee with 0 eth");

        // add the memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a log event when a new memo is create
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /*
    * @dev send the entire balance stored in contract ot the owner
    */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /*
    * @dev retried all the memos received and stored on the blockchain
    */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
    
}
