//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );

        console.log(
            "Most recently deployed contract address:",
            mostRecentlyDeployed
        );

        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );

        console.log(
            "Most recently deployed contract address:",
            mostRecentlyDeployed
        );

        mintMoodNftOnContract(mostRecentlyDeployed);
    }

    function mintMoodNftOnContract(address contractAdress) public {
        vm.startBroadcast();
        MoodNft(contractAdress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );

        console.log(
            "Most recently deployed contract address:",
            mostRecentlyDeployed
        );

        uint256 tokenId = vm.envUint("TOKEN_ID");
        flipMoodNftOnContract(mostRecentlyDeployed, tokenId);
    }

    function flipMoodNftOnContract(
        address contractAddress,
        uint256 tokenId
    ) public {
        vm.startBroadcast();
        MoodNft(contractAddress).flipMood(tokenId);
        vm.stopBroadcast();
    }
}
