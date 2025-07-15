// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    enum state { active, ended }

    struct Bid {
        bool is_decrypted;
        bool is_burned;
        bool will_compute;
    }

    mapping(uint => Bid) public bids;
    uint[] public bids_decrypted;
    uint public bids_reset_count;
    uint public bids_decrypted_count;
    uint public bids_sorted_count;
    uint public bids_ignored_count;
    uint public bids_burned_count;
    state public status;

    constructor() Ownable(msg.sender) {
        // Initialize all instance variables to fixed, safe, non-corner-case values
        bids_reset_count = 0;
        bids_decrypted_count = 1;
        bids_sorted_count = 0;
        bids_ignored_count = 0;
        bids_burned_count = 0;
        status = state.ended;
    }

    function resetAppendDecryptedBids(uint _count) public onlyOwner {
        require(status == state.ended);
        require(bids_decrypted_count > 0);
        require(_count > 0);

        if (bids_reset_count == 0) {
            bids_reset_count = bids_decrypted_count;
        }

        uint count = _count;
        if (bids_reset_count < count) {
            count = bids_reset_count;
        }

        do {
            bids_reset_count--;
            bids[bids_decrypted[bids_reset_count]].is_decrypted = false;
            bids[bids_decrypted[bids_reset_count]].is_burned = false;
            bids[bids_decrypted[bids_reset_count]].will_compute = false;
            count--;
        } while (count > 0);

        if (bids_reset_count == 0) {
            bids_sorted_count = 0;
            bids_ignored_count = 0;
            bids_decrypted_count = 0;
            bids_burned_count = 0;
        }
    }
}