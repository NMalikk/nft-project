
# MoodNFT Project

This project involves the deployment and interaction with a MoodNFT smart contract. Below is a detailed guide to help you set up, deploy, and interact with the MoodNFT contract using the provided Makefile.

## Prerequisites

- Install [Foundry](https://book.getfoundry.sh/getting-started/installation.html)
- Set up an Ethereum node or use an RPC endpoint (e.g., Infura, Alchemy)
- Ensure you have the necessary private keys and API keys set in a `.env` file

## Environment Variables

Create a `.env` file in the root directory with the following content:

```sh
SEPOLIA_RPC_URL=<your_sepolia_rpc_url>
PRIVATE_KEY=<your_private_key>
ETHERSCAN_API_KEY=<your_etherscan_api_key>
TOKEN_ID=<your_token_id>
```

## Makefile Targets

```makefile
-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil 

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo "  make fund [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install Cyfrin/foundry-devops@0.1.0 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft $(NETWORK_ARGS)

mint:
	@forge script script/Interactions.s.sol:MintBasicNft ${NETWORK_ARGS}

deployMood:
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft $(NETWORK_ARGS)

mintMoodNft: 
	@forge script script/Interactions.s.sol:MintMoodNft $(NETWORK_ARGS)

flipMoodNft: #make sure to set a variable for tokenId as "TOKEN_ID" in env files. 
	@forge script script/Interactions.s.sol:FlipMoodNft $(NETWORK_ARGS)

customMintMood:
	@cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "mintNft()" --private-key ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url http://localhost:8545

customFlipMood:
	@cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "flipMood(uint256)" 0 --private-key ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url http://localhost:8545
```

## Network Arguments

By default, the script uses a local Anvil node. If the `--network sepolia` argument is provided, it will use the Sepolia network with appropriate RPC URL and keys.

## Deployment and Interaction

- **deploy**: Deploys the `BasicNft` contract.
  ```sh
  make deploy ARGS="--network sepolia"
  ```
- **mint**: Mints a Basic NFT.
  ```sh
  make mint ARGS="--network sepolia"
  ```
- **deployMood**: Deploys the `MoodNft` contract.
  ```sh
  make deployMood ARGS="--network sepolia"
  ```
- **mintMoodNft**: Mints a Mood NFT.
  ```sh
  make mintMoodNft ARGS="--network sepolia"
  ```
- **flipMoodNft**: Flips the mood of a Mood NFT (set `TOKEN_ID` in `.env`).
  ```sh
  make flipMoodNft ARGS="--network sepolia"
  ```
- **customMintMood**: Custom mint Mood NFT using `cast send`.
  ```sh
  make customMintMood
  ```
- **customFlipMood**: Custom flip mood using `cast send`.
  ```sh
  make customFlipMood
  ```

## Usage Instructions

1. **Set Up Environment**: Ensure you have all the necessary dependencies and environment variables set up.
2. **Run Commands**: Use the provided Makefile targets to deploy and interact with your MoodNFT contract.
3. **Customize and Extend**: Modify the Makefile and scripts as needed for your specific use case.


## Development

This project was developed as part of the Advanced Foundry Course by Cyfrin. The course provided the foundational knowledge and guidance necessary to build and deploy this smart raffle contract.

## Credits

Special thanks to Cyfrin for offering the course materials and support throughout the development of this project.
